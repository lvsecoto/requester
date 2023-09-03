import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:requester/common/error/error.dart';

import 'progress.dart';

extension ProgressErrorEx on WidgetRef {
  /// 观察[Progress]并处理[UserError]
  String? watchError(ProviderBase<Progress> provider) =>
      switch (watch(provider)) {
        ProgressError(:final e) => switch (e) {
            UserError(message: var message) => message,
            _ => null,
          },
        _ => null,
      };
}

extension ProgressLoadingEx on WidgetRef {
  /// 观察是否在加载中
  bool watchLoading(ProviderBase<Progress> provider) =>
      switch (watch(provider)) {
        ProgressDeterminate() || ProgressIndeterminate() => true,
        _ => false,
      };
}

/// 封装一个操作异步[run]为Progress，并且可以被Provider观察执行过程
mixin ProgressingAction<Input> on AutoDisposeNotifier<Progress> {
  late Input _input;

  /// 在[build]中调用
  Progress onBuild(Input input) {
    _input = input;
    return const Progress.done();
  }

  /// 开始任务
  ///
  /// ```dart
  /// ref.read(actionProvider.notifier)();
  /// ```
  Future<void> call() async {
    if (!state.isDone) {
      return;
    }
    state = const Progress.indeterminate();
    try {
      await run(_input);
      state = const Progress.done();
    } catch (e, stackTrace) {
      state = Progress.error(e, stackTrace);
      rethrow;
    }
  }

  /// 实现这个方法，在里面调用异步任务
  ///
  /// [input]是在[onBuild]中传入的参数
  Future run(Input input);
}

mixin ProgressingActionResult<Input, Result>
    on AutoDisposeNotifier<Progress<Result>> {
  late Input _input;

  /// 在[build]中调用
  Progress<Result> onBuild(Input input) {
    _input = input;
    return const Progress.done();
  }

  Completer<Result>? _completer;

  /// 开始任务
  ///
  /// ```dart
  /// ref.read(actionProvider.notifier)();
  /// ```
  Future<Result> call() async {
    if (!state.isDone) {
      return await _completer!.future;
    }
    state = const Progress.indeterminate();
    final completer = Completer<Result>();
    _completer = completer;
    unawaited(run(_input).then((result) {
      completer.complete(result);
      state = Progress.done(result);
    }, onError: (e, stackTrace) {
      completer.completeError(e, stackTrace);
      state = Progress.error(e, stackTrace);
    }));
    return completer.future;
  }

  /// 实现这个方法，在里面调用异步任务
  ///
  /// [input]是在[onBuild]中传入的参数
  Future<Result> run(Input input);
}
