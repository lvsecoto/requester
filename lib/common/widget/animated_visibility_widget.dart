import 'package:flutter/material.dart';

Widget _defaultAnimationWidgetBuilder(
    BuildContext context,
    Animation<double> animation,
    Widget? child,
    ) {
  return SizeTransition(
    axis: Axis.horizontal,
    sizeFactor: animation,
    axisAlignment: 0.0,
    child: child,
  );
}

class AnimatedVisibilityWidget extends StatefulWidget {
  /// 每当[isVisible]出现变化时，就会执行时长[duration]，曲线[curve]的动画
  ///
  /// 默认动画是从左到右进入显示
  const AnimatedVisibilityWidget({
    super.key,
    required this.isVisible,
    required this.child,
    this.animationWidgetBuilder = _defaultAnimationWidgetBuilder,
    this.duration = const Duration(milliseconds: 180),
    this.curve = Curves.easeIn,
    this.isInitAnimated = false,
    this.onDone,
  });

  /// 淡出淡入效果
  static Widget fadeAnimationWidgetBuilder(
      BuildContext context,
      Animation<double> animation,
      Widget? child,
      ) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  /// 垂直从上到下进入显示
  static Widget verticalAnimationWidgetBuilder(
      BuildContext context,
      Animation<double> animation,
      Widget? child,
      ) {
    return SizeTransition(
      axis: Axis.vertical,
      sizeFactor: animation,
      axisAlignment: 1.0,
      child: child,
    );
  }

  /// 缩小消失，放大显示
  static Widget scaleAnimationWidgetBuilder(
      BuildContext context,
      Animation<double> animation,
      Widget? child,
      ) {
    return ScaleTransition(
      scale: animation,
      child: child,
    );
  }

  /// 要执行动画的[Widget]
  final Widget? child;

  /// 通过改变这个值实现动画
  final bool isVisible;

  final bool isInitAnimated;

  /// 动画时长
  final Duration duration;

  /// 动画曲线
  final Curve curve;

  /// 当显示状态变化时（稳定状态，非动画状态）
  final Function(bool visible)? onDone;

  /// 用[Animation<double>]来创建变换动画
  final ValueWidgetBuilder<Animation<double>> animationWidgetBuilder;

  @override
  State<AnimatedVisibilityWidget> createState() =>
      _AnimatedVisibilityWidgetState();
}

class _AnimatedVisibilityWidgetState extends State<AnimatedVisibilityWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (_animationController.value == 1.0) {
          widget.onDone?.call(true);
        } else if (_animationController.value == 0.0) {
          widget.onDone?.call(false);
        }
      }
    });
    _animation = CurvedAnimation(
      curve: widget.curve,
      parent: _animationController,
    );
    if (!widget.isInitAnimated) {
      _animationController.value = widget.isVisible ? 1.0 : 0.0;
    } else {
      _animationController.value = widget.isVisible ? 0.0 : 1.0;
    }
    _setupAnimationWithVisibility();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(AnimatedVisibilityWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _animationController.duration = widget.duration;
    _animation = CurvedAnimation(
      curve: widget.curve,
      parent: _animationController,
    );
    _setupAnimationWithVisibility();
  }

  void _setupAnimationWithVisibility() {
    if (widget.isVisible) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.animationWidgetBuilder(context, _animation, widget.child);
  }
}
