import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'progress.dart';

/// 根据进度显示的按钮
class ProgressLoadingOutlinedButton extends HookWidget {
  const ProgressLoadingOutlinedButton._({
    super.key,
    required this.progress,
    this.icon,
    required this.label,
    required this.style,
    required this.onPressed,
  });

  factory ProgressLoadingOutlinedButton({
    Key? key,
    required Progress progress,
    required Widget child,
    required VoidCallback? onPressed,
    ButtonStyle? style,
  }) =>
      ProgressLoadingOutlinedButton._(
        key: key,
        progress: progress,
        label: child,
        style: style,
        onPressed: onPressed,
      );

  factory ProgressLoadingOutlinedButton.icon({
    Key? key,
    required Progress progress,
    required Widget label,
    required Widget icon,
    ButtonStyle? style,
    required VoidCallback? onPressed,
  }) =>
      ProgressLoadingOutlinedButton._(
        key: key,
        progress: progress,
        label: label,
        icon: icon,
        style: style,
        onPressed: onPressed,
      );

  final Progress progress;

  /// 按钮上面的文字
  final Widget label;

  /// 图标，为空的话就不显示
  final Widget? icon;

  /// 点击回调
  final VoidCallback? onPressed;
  
  ///
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: kThemeAnimationDuration,
    );

    final isDone = progress.isDone;

    useEffect(() {
      if (isDone) {
        animationController.reverse();
      } else {
        animationController.forward();
      }
      return null;
    }, [isDone]);

    final icon = FadeTransition(
      opacity: ReverseAnimation(animationController),
      child: this.icon,
    );

    final label = FadeTransition(
      opacity: ReverseAnimation(animationController),
      child: this.label,
    );

    /// 加载时禁止操作
    final onPressed = isDone ? this.onPressed : () {};

    Widget button;
    if (this.icon != null) {
      button = OutlinedButton.icon(
        style: style,
        onPressed: onPressed,
        label: label,
        icon: icon,
      );
    } else {
      button = OutlinedButton(
        style: style,
        onPressed: onPressed,
        child: label,
      );
    }

    return Stack(
      children: [
        button,
        Positioned.fill(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: AspectRatio(
                aspectRatio: 1.0,
                child: FadeTransition(
                  opacity: animationController,
                  child: IgnorePointer(
                    child: CircularProgressIndicator(
                      color: style?.foregroundColor?.resolve({}),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// 根据进度显示的按钮
class ProgressLoadingFilledButton extends HookWidget {
  const ProgressLoadingFilledButton._({
    super.key,
    required this.progress,
    this.icon,
    required this.label,
    required this.onPressed,
    this.isTonal = false,
  });

  factory ProgressLoadingFilledButton({
    Key? key,
    required Progress progress,
    required Widget child,
    required VoidCallback? onPressed,
  }) =>
      ProgressLoadingFilledButton._(
        key: key,
        progress: progress,
        label: child,
        onPressed: onPressed,
      );

  factory ProgressLoadingFilledButton.tonal({
    Key? key,
    required Progress progress,
    required Widget child,
    required VoidCallback? onPressed,
  }) =>
      ProgressLoadingFilledButton._(
        key: key,
        progress: progress,
        label: child,
        onPressed: onPressed,
        isTonal: true,
      );

  factory ProgressLoadingFilledButton.icon({
    Key? key,
    required Progress progress,
    required Widget label,
    required Widget icon,
    required VoidCallback? onPressed,
  }) =>
      ProgressLoadingFilledButton._(
        key: key,
        progress: progress,
        label: label,
        icon: icon,
        onPressed: onPressed,
      );

  factory ProgressLoadingFilledButton.tonalIcon({
    Key? key,
    required Progress progress,
    required Widget label,
    required Widget icon,
    required VoidCallback? onPressed,
  }) =>
      ProgressLoadingFilledButton._(
        key: key,
        progress: progress,
        label: label,
        icon: icon,
        isTonal: true,
        onPressed: onPressed,
      );

  final Progress progress;

  /// 按钮上面的文字
  final Widget label;

  /// 图标，为空的话就不显示
  final Widget? icon;

  /// 是否是tonal风格按钮
  final bool isTonal;

  /// 点击回调
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: kThemeAnimationDuration,
    );

    final isDone = progress.isDone;

    useEffect(() {
      if (isDone) {
        animationController.reverse();
      } else {
        animationController.forward();
      }
      return null;
    }, [isDone]);

    final icon = FadeTransition(
      opacity: ReverseAnimation(animationController),
      child: this.icon,
    );

    final label = FadeTransition(
      opacity: ReverseAnimation(animationController),
      child: this.label,
    );

    /// 加载时禁止操作
    final onPressed = isDone ? this.onPressed : () {};

    Widget button;
    if (isTonal) {
      if (this.icon != null) {
        button = FilledButton.tonalIcon(
          onPressed: onPressed,
          label: label,
          icon: icon,
        );
      } else {
        button = FilledButton.tonal(
          onPressed: onPressed,
          child: label,
        );
      }
    } else {
      if (this.icon != null) {
        button = FilledButton.icon(
          onPressed: onPressed,
          label: label,
          icon: icon,
        );
      } else {
        button = FilledButton(
          onPressed: onPressed,
          child: label,
        );
      }
    }

    return Stack(
      children: [
        button,
        Positioned.fill(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: AspectRatio(
                aspectRatio: 1.0,
                child: FadeTransition(
                  opacity: animationController,
                  child: IgnorePointer(
                    child: CircularProgressIndicator(
                      color: isTonal
                          ? null
                          : Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
