import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'progress.dart';

class ProgressLoadingWidget extends HookWidget {
  /// 在[child]表面显示进度[progress]的加载进度
  const ProgressLoadingWidget({
    super.key,
    required this.child,
    required this.progress,
  });

  final Widget child;
  final Progress? progress;

  @override
  Widget build(BuildContext context) {
    final progress = this.progress ?? const Progress.indeterminate();
    const duration = Duration(milliseconds: 320);
    final controller = useAnimationController(
      initialValue: 1.0,
    );

    final isAnimating = useState(false);
    final indeterminate = useState(false);

    useMemoized(() {
      controller.addListener(() {
        isAnimating.value = controller.isAnimating;
      });
    });

    final showProgress = isAnimating.value;

    useEffect(() {
      progress.map(
        (value) {
          final target = value.current / value.total;
          controller.animateTo(target,
              duration: duration, curve: Curves.easeInCubic);
          indeterminate.value = true;
        },
        indeterminate: (it) {
          controller.value = 0;
          indeterminate.value = true;
        },
        done: (_) {
          controller.animateTo(1.0,
              duration: duration, curve: Curves.easeInCubic);
          indeterminate.value = false;
        },
        error: (_) {
          controller.animateTo(1.0,
              duration: duration, curve: Curves.easeInCubic);
          indeterminate.value = false;
        },
      );
      return null;
    }, [progress]);

    Widget progressWidget;

    if (indeterminate.value) {
      progressWidget = const LinearProgressIndicator();
    } else {
      if (showProgress) {
        progressWidget = AnimatedBuilder(
          key: const ValueKey(true),
          animation: controller,
          builder: (context, _) => LinearProgressIndicator(
            key: const ValueKey(false),
            value: controller.value,
          ),
        );
      } else {
        progressWidget = const SizedBox.shrink(
          key: ValueKey(null),
        );
      }
    }

    return Stack(
      children: [
        Positioned.fill(
          top: null,
          child: AnimatedSwitcher(
            duration: kThemeAnimationDuration,
            child: progressWidget,
          ),
        ),
        child,
      ],
    );
  }
}

class FutureStateWidget extends HookConsumerWidget {
  /// 输入[provider]，
  ///
  /// 当[provider]成功后，显示[child]
  /// 当[provider]加载时，显示加载中效果
  /// 当[provider]失败时，显示错误，并显示重试按钮
  const FutureStateWidget({
    super.key,
    required this.provider,
    required this.child,
  });

  final AutoDisposeStreamProvider provider;

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(provider);

    return SizedBox.expand(
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            child: state.value.map(
              (it) => TweenAnimationBuilder<double>(
                duration: kThemeAnimationDuration,
                curve: Curves.easeInOut,
                tween: Tween<double>(
                  begin: 0,
                  end: it.current / it.total,
                ),
                builder: (context, value, _) =>
                    LinearProgressIndicator(value: value),
              ),
              indeterminate: (it) => const LinearProgressIndicator(),
              done: (value) => const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}
