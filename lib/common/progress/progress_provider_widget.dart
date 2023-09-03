import 'package:animations/animations.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'progress.dart';
import 'progress_loading_widget.dart';

class ProgressProviderStateWidget extends HookConsumerWidget {
  /// 显示[provider]的加载状态
  ///
  /// * 加载中的时候显示进度条
  /// * 加载失败显示错误信息，并且显示重试按钮
  /// * 加载过程不显示[child]，成功后动画呈现[child]
  const ProgressProviderStateWidget({
    super.key,
    required this.provider,
    required this.child,
  });

  final AutoDisposeStreamProvider<Progress> provider;

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(provider);

    Widget child;
    if (asyncValue.hasError) {
      child = Center(
        child: ElevatedButton(
          onPressed: () {
            ref.invalidate(provider);
          },
          child: const Text('重试'),
        ),
      );
    } else {
      child = AnimatedVisibilityWidget(
        isInitAnimated: true,
        isVisible: true,
        duration: const Duration(milliseconds: 150),
        animationWidgetBuilder: (context, animation, child) =>
            FadeScaleTransition(
          animation: animation,
          child: child,
        ),
        child: this.child,
      );
    }

    return ProgressLoadingWidget(
      progress: ref.watch(provider).value,
      child: SizedBox.expand(child: child),
    );
  }
}
