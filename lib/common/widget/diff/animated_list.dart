import 'package:animated_list_plus/animated_list_plus.dart';
import 'package:animated_list_plus/transitions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class DiffSliverAnimatedList<T extends Object> extends StatelessWidget {
  static bool defaultAreItemsTheSame(dynamic oldItem, dynamic newItem) {
    return oldItem == newItem;
  }

  /// 用[areItemsTheSame]比较[items]的变化，实现列表条目动画效果
  const DiffSliverAnimatedList({
    super.key,
    required this.items,
    this.itemBuilder,
    this.indexedItemBuilder,
    this.areItemsTheSame = defaultAreItemsTheSame,
    this.keySelector,
  }) : assert(
          (itemBuilder != null && indexedItemBuilder == null) ||
              (indexedItemBuilder != null && itemBuilder == null),
          '二选其一',
        );

  final List<T> items;

  final bool Function(T oldItem, T newItem) areItemsTheSame;

  final Widget Function(BuildContext context, T item)? itemBuilder;

  final Widget Function(BuildContext context, T item, int index)?
      indexedItemBuilder;

  final Object Function(T item)? keySelector;

  @override
  Widget build(BuildContext context) {
    final scrollableState = Scrollable.maybeOf(context);
    final axisDirection = scrollableState?.axisDirection;
    final axis =
        (axisDirection == null ? null : axisDirectionToAxis(axisDirection)) ??
            Axis.vertical;
    return SliverImplicitlyAnimatedList<T>(
      items: items,
      areItemsTheSame: areItemsTheSame,
      itemBuilder: (context, animation, item, index) => KeyedSubtree(
        key: ValueKey(keySelector?.call(item) ?? item),
        child: SizeFadeTransition(
          sizeFraction: 0.7,
          curve: Curves.easeInOut,
          axis: axis,
          animation: animation,
          child: itemBuilder != null
              ? itemBuilder!(context, item)
              : indexedItemBuilder!(context, item, index),
        ),
      ),
      removeItemBuilder: (context, animation, oldItem) => SizeFadeTransition(
        key: ValueKey(oldItem),
        sizeFraction: 0.7,
        axis: axis,
        curve: Curves.easeInOut,
        animation: animation,
        child: itemBuilder != null
            ? itemBuilder!(context, oldItem)
            : indexedItemBuilder!(context, oldItem, 0),
      ),
    );
  }
}

class DiffReorderAnimatedList<T extends Object> extends StatelessWidget {
  static bool defaultAreItemsTheSame(dynamic oldItem, dynamic newItem) {
    return oldItem == newItem;
  }

  /// 用[areItemsTheSame]比较[items]的变化，实现列表条目动画效果
  const DiffReorderAnimatedList({
    super.key,
    required this.items,
    this.itemBuilder,
    this.indexedItemBuilder,
    this.areItemsTheSame = defaultAreItemsTheSame,
    this.keySelector,
    required this.onReordered,
    this.padding,
    this.header,
    this.footer,
  }) : assert(
          (itemBuilder != null && indexedItemBuilder == null) ||
              (indexedItemBuilder != null && itemBuilder == null),
          '二选其一',
        );

  final List<T> items;

  final bool Function(T oldItem, T newItem) areItemsTheSame;

  final Widget Function(BuildContext context, T item, bool inDrag)? itemBuilder;

  final Widget Function(BuildContext context, T item, int index, bool inDrag)?
      indexedItemBuilder;

  final Object Function(T item)? keySelector;

  final void Function(List<T> items) onReordered;

  final EdgeInsets? padding;

  final Widget? header;

  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    final scrollableState = Scrollable.maybeOf(context);
    final axisDirection = scrollableState?.axisDirection;
    final axis =
        (axisDirection == null ? null : axisDirectionToAxis(axisDirection)) ??
            Axis.vertical;
    return ImplicitlyAnimatedReorderableList(
      padding: padding,
      items: items,
      areItemsTheSame: areItemsTheSame,
      onReorderFinished: (item, from, to, newItems) {
        onReordered(newItems);
      },
      header: header,
      footer: footer,
      itemBuilder: (context, itemAnimation, item, index) => Reorderable(
        key: ValueKey(keySelector?.call(item) ?? item),
        builder: (context, animation, inDrag) => SizeFadeTransition(
          sizeFraction: 0.7,
          curve: Curves.easeInOut,
          axis: axis,
          animation: itemAnimation,
          child: Handle(
            delay: kLongPressTimeout * 1.3,
            child: itemBuilder != null
                ? itemBuilder!(context, item, inDrag)
                : indexedItemBuilder!(context, item, index, inDrag),
          ),
        ),
      ),
      removeItemBuilder: (context, animation, oldItem) => Reorderable(
        key: ValueKey(oldItem),
        child: SizeFadeTransition(
          sizeFraction: 0.7,
          axis: axis,
          curve: Curves.easeInOut,
          animation: animation,
          child: itemBuilder != null
              ? itemBuilder!(context, oldItem, false)
              : indexedItemBuilder!(context, oldItem, 0, false),
        ),
      ),
    );
  }
}
