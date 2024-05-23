/// 这里通过mixin给ProviderNotifier添加一些常用操作
// ignore_for_file: invalid_use_of_internal_member

library provider.notiifer;

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod/riverpod.dart';

// ignore: implementation_imports
import 'package:riverpod/src/framework.dart';

// ignore: implementation_imports
import 'package:riverpod/src/notifier.dart';

/// 给Notifier添加选择功能
mixin SelectableNotifier<T> on BuildlessAutoDisposeNotifier<T> {
  /// 选择值
  void select(T value) {
    if (stateOrNull != value) {
      state = value;
    }
  }

  /// 清除值
  void clear() {
    state = null as dynamic;
  }
}

/// 给Notifier增加开关功能
mixin ToggleableNotifier on BuildlessAutoDisposeNotifier<bool> {
  /// 切换状态
  void toggle() {
    state = !state;
  }

  /// 打开状态
  void check() {
    state = true;
  }

  /// 关闭状态
  void unCheck() {
    state = false;
  }
}

abstract class ToggleableStateNotifier<T> {
  /// 切换状态
  void toggle(T value);
}

/// 给Notifier增加单选功能
mixin RadioToggleNotifier<T> on BuildlessAutoDisposeNotifier<Set<T>>
    implements ToggleableStateNotifier<T> {
  /// 切换状态
  @override
  void toggle(T value) {
    if (!state.contains(value)) {
      state = {
        value,
      };
    }
  }
}

/// 给Notifier增加多选功能
mixin CheckedToggleNotifier<T> on BuildlessAutoDisposeNotifier<Set<T>>
    implements ToggleableStateNotifier<T> {
  final num maxSelect = double.infinity;

  final num minSelect = 0;

  /// 切换状态
  @override
  void toggle(T value) {
    if (state.length >= minSelect + 1 && state.contains(value)) {
      state = {
        ...state,
      }..remove(value);
    } else if (state.length <= maxSelect - 1 && !state.contains(value)) {
      state = {
        ...state,
        value,
      };
    }
  }

  void clear() {
    state = {};
  }
}

mixin DeferFutureNotifier<T> on BuildlessAutoDisposeNotifier<AsyncValue<T>?> {
  bool _connected = false;

  // ignore: avoid_public_notifier_properties
  late AsyncSelector<T> _provider;

  AsyncValue<T>? onBuild(AsyncSelector<T> provider) {
    this._provider = provider;
    if (_connected) {
      return ref.watch(provider);
    }
    ref.onCancel(() {
      _connected = false;
    });
    return null;
  }

  void reset() {
    _connected = false;
    ref.invalidateSelf();
  }

  Future<T> refresh({bool useCache = false}) async {
    if (!_connected) {
      _connected = true;
      ref.invalidateSelf();
    }
    if (!ref.read(_provider).isLoading) {
      if (useCache) {
        if (ref.read(_provider).hasValue) {
          state = null;
          state = ref.read(_provider);
          return ref.read(_provider.future).then((value) {
            state = null;
            return value;
          });
        } else {
          state = const AsyncValue.loading();
          return ref.refresh(_provider.future);
        }
      } else {
        state = const AsyncValue.loading();
        return ref.refresh(_provider.future);
      }
    } else {
      state = const AsyncValue.loading();
      return ref.read(_provider.future);
    }
  }
}

mixin StreamValueNotifier<T> on BuildlessAutoDisposeNotifier<T?> {
  /// 桥接Stream
  StreamSubscription? _subscription;

  T? onBuild() {
    _completer = Completer();
    _subscription = buildStream().listen((next) {
      state = next;
      if (!_completer.isCompleted) {
        _completer.complete(next);
      }
    });
    ref.onDispose(() {
      if (!_completer.isCompleted) {
        _completer.complete(null);
      }
      _subscription?.cancel();
    });
    return null;
  }

  late Completer<T> _completer;

  /// 确保在拿到值的时候，数据已经准备完毕
  Future<T> get future async {
    final data = await _completer.future;
    return state ?? data;
  }

  Stream<T> buildStream();
}

/// 每当[changeNotifier]变化，会引起Notifier变化
///
/// 变化的值是从[selectController]获取到的
mixin ChangeNotifierNotifier<N extends ChangeNotifier, T>
    on BuildlessAutoDisposeNotifier<T> {
  T selectController(N changeNotifier);

  @mustCallSuper
  T onBuild(N changeNotifier) {
    void onListener() {
      final value = selectController(changeNotifier);
      if (state != value) {
        onChange(value);
      }
    }

    changeNotifier.addListener(onListener);
    ref.onDispose(() {
      changeNotifier.removeListener(onListener);
    });
    return selectController(changeNotifier);
  }

  @visibleForOverriding
  @mustCallSuper
  void onChange(T value) {
    state = value;
  }
}

/// 兼容[TextEditController]的notifier
///
/// ```dart
/// // 兼容@riverpod自动生成
/// @riverpod
/// class SomeTextEditNotifier extends _$SomeTextEditNotifier with TextEditNotifier {
///   @override
///   String build() {
///     return super.build();
///   }
/// }
///
/// // 在Widget使用
/// TextField(
///   controller: ref.watch(textEditNotifierProvider.notifier).controller,
/// )
///
/// // 可以在外部改变controller的值
/// ref.watch(textEditNotifierProvider.notifier).text = 'new text'
///
/// ```
mixin TextEditNotifier on BuildlessAutoDisposeNotifier<String> {
  final _controller = TextEditingController();

  /// [controller]可以被TextField使用
  TextEditingController get controller => _controller;

  @mustBeOverridden
  @mustCallSuper
  String build() {
    void onChange() {
      if (_controller.text != state) {
        onTextChange();
      }
    }

    _controller.text = buildInitText();
    ref.onDispose(() {
      _controller.removeListener(onChange);
    });
    _controller.addListener(onChange);
    return _controller.text;
  }

  @mustCallSuper
  void onTextChange() {
    state = _controller.text;
  }

  /// 改变controller的值
  set text(String value) {
    _controller.text = value;
  }

  /// _controller的初始化文本，可以override
  String buildInitText() {
    return '';
  }
}

mixin TextEditControllerNotifier on BuildlessAutoDisposeNotifier<String> {
  TextEditingController? _controller;

  /// [controller]可以被TextField使用
  TextEditingController? get controller => _controller;

  String onBuild() {
    _controller ??= TextEditingController();
    void onChange() {
      if (_controller!.text != state) {
        onTextChange();
      }
    }

    controller!.text = buildInitText();
    ref.onDispose(() {
      controller!.removeListener(onChange);
    });
    controller!.addListener(onChange);
    return controller!.text;
  }

  @mustCallSuper
  void onTextChange() {
    state = _controller!.text;
  }

  /// 改变controller的值
  set text(String value) {
    _controller!.text = value;
  }

  /// _controller的初始化文本，可以override
  String buildInitText() {
    return '';
  }

  /// 清除输入
  void clear() {
    text = '';
  }
}

/// 焦点Notifier
mixin FocusNotifier on BuildlessAutoDisposeNotifier<bool> {
  final _focusNode = FocusNode();

  bool onBuild() {
    _focusNode.addListener(onChange);
    ref.onDispose(() {
      _focusNode.removeListener(onChange);
    });
    return _focusNode.hasFocus;
  }

  void onChange() {
    state = _focusNode.hasFocus;
  }

  FocusNode get focusNode => _focusNode;

  /// 获取焦点
  void requestFocus() {
    focusNode.requestFocus();
  }

  /// 取消焦点
  void unfocus() {
    focusNode.unfocus();
  }
}

class DownCounterState {
  DownCounterState(this.value);

  final int value;

  /// 倒计时是否在进行中
  bool get isRunning => value != 0;
}

/// 倒计时
mixin DownCounterNotifier on BuildlessAutoDisposeNotifier<DownCounterState> {
  /// 倒计时共多少秒
  int getCounterInSecond();

  Timer? _timer;

  DownCounterState onBuild() {
    ref.onDispose(() {
      _timer?.cancel();
    });
    return DownCounterState(0);
  }

  void restart() {
    state = DownCounterState(getCounterInSecond());

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      state = DownCounterState(state.value - 1);
      if (state.value == 0) {
        _timer?.cancel();
      }
    });
  }
}
