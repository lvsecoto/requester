import 'package:flutter/material.dart';

class AnimatedSizeAndFade extends StatelessWidget {
  /// 每当Child内容发送改变，就会产生动画
  ///
  /// * 大小发送改变，会有边界变换效果
  /// * 内容变化，会有淡出淡入效果(和大小变化不一样，内容变化是通过[child]的类型或者key识别)
  /// * 可以指定变化时，组件对齐的位置，比如一个上下展开收起效果的组件，那么它的[alignment]应该传[Alignment.topCenter]
  const AnimatedSizeAndFade({
    super.key,
    required this.child,
    this.childKey,
    this.alignment = Alignment.center,
    this.duration,
    this.curve,
    this.switchInCurve,
    this.switchOutCurve,
    this.sized,
  });

  final Widget child;

  /// 变化对齐位置
  final Alignment alignment;

  /// 如果有，会作为[ValueKey]包裹在[child]，方便实现内容变化动画效果
  final Object? childKey;

  /// 变化时间
  final Duration? duration;

  final Curve? curve;

  final Curve? switchInCurve;

  final Curve? switchOutCurve;

  final bool? sized;

  @override
  Widget build(BuildContext context) {
    var child = this.child;
    if (childKey != null) {
      child = KeyedSubtree(
        key: ValueKey(childKey),
        child: child,
      );
    }
    child = AnimatedSwitcher(
        duration: duration ?? kThemeAnimationDuration,
        switchInCurve: switchInCurve ?? Curves.linear,
        switchOutCurve: switchOutCurve ?? Curves.linear,
        layoutBuilder: (currentChild, previousChildren) => Stack(
          clipBehavior: Clip.none,
          alignment: alignment,
          children: <Widget>[
            ...previousChildren,
            if (currentChild != null) currentChild,
          ],
        ),
        child: child,
      );
    if (sized ?? true) {
      return AnimatedSize(
        alignment: alignment,
        duration: duration ?? kThemeAnimationDuration,
        curve: curve ?? Curves.linear,
        child: child,
      );
    }
    return child;
  }
}
