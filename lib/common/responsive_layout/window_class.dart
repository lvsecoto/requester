import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'window_class.g.dart';

/// 获取窗口大小类别
@riverpod
class WindowClassNotifier extends _$WindowClassNotifier {
  @override
  WindowClass build() {
    return WindowClass.compact;
  }

  void update(WindowClass value) {
    state = value;
  }
}

/// 窗口大小类别
enum WindowClass {
  compact(maxWidth: 400.0),
  medium(maxWidth: 600.0),
  expand(maxWidth: double.infinity);

  final double maxWidth;
  const WindowClass({required this.maxWidth});
}

class WindowClassNotifierWidget extends HookConsumerWidget {
  /// 这个Widget会检测窗口大小变化
  ///
  /// 并通过[of]来提供动画效果来给下面的组件实现响应布局变化的动画效果
  ///
  /// 每当[of]返回的动画执行到最后，才回通过[WindowClassNotifier]通知窗口变化大小
  ///
  /// 加上这个动画，是为了避免界面布局跳动，给用户不好的体验
  ///
  /// 比如，有一些布局，在不同的[WindowClass]，要用不一样的大小，在大屏幕宽度固定，小屏幕宽度全屏
  /// ```dart
  /// FadeTransition(
  ///   opacity: WindowClassNotifierWidget.animation(context),
  ///   Size(
  ///     width: ref.watch(windowClassNotifierProvider) == WindowClass.compact ? double.infinity : 320,
  ///   );
  /// )
  /// ```
  const WindowClassNotifierWidget({
    super.key,
    required this.child,
  });

  static Animation<double> animation(BuildContext context) => ReverseAnimation(
        CurvedAnimation(
          curve: Curves.easeIn,
          reverseCurve: Curves.easeOut,
          parent: _WindowClassNotifierWidgetHolder.of(context)
              .screenChangeAnimation,
        ),
      );

  final Widget child;

  @override
  Widget build(BuildContext context, ref) {
    final width = MediaQuery.of(context).size.width;
    final size = useRef<WindowClass>(WindowClass.expand);
    if (width > WindowClass.medium.maxWidth) {
      size.value = WindowClass.expand;
    } else {
      size.value = WindowClass.compact;
    }
    final screenChangeAnimation = useAnimationController(
      duration: kThemeAnimationDuration,
    );
    useMemoized(() {
      Future(() {
        // 必须在非Building的状态下调用，不然会报错
        ref.read(windowClassNotifierProvider.notifier).update(size.value);
      });
      void onUpdate(AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            ref.read(windowClassNotifierProvider.notifier).update(size.value);
          });
          screenChangeAnimation.reverse();
        }
      }

      screenChangeAnimation.addStatusListener(onUpdate);
      return () => screenChangeAnimation.removeStatusListener(onUpdate);
    });
    useValueChanged<WindowClass, dynamic>(size.value, (oldValue, oldResult) {
      // 窗口大小变化，执行动画，等动画结束后才应用窗口大小
      screenChangeAnimation.forward();
    });

    return _WindowClassNotifierWidgetHolder(
      screenChangeAnimation: screenChangeAnimation,
      child: child,
    );
  }
}

class _WindowClassNotifierWidgetHolder extends InheritedWidget {
  const _WindowClassNotifierWidgetHolder({
    required this.screenChangeAnimation,
    required super.child,
  });

  static _WindowClassNotifierWidgetHolder of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<_WindowClassNotifierWidgetHolder>()!;

  /// 每当界面大小发生变化，判断到界面大小类型变化后，当这个动画会开启，运行到1后，
  /// [windowClassNotifierProvider]才会应用变化
  final AnimationController screenChangeAnimation;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
