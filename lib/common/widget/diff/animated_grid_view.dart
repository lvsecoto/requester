import 'package:flutter/material.dart';
import 'package:flutter_reorderable_grid_view/widgets/reorderable_builder.dart';
import 'package:dartx/dartx.dart';

class DiffAnimatedGridView<T> extends StatelessWidget {
  const DiffAnimatedGridView({
    super.key,
    required this.items,
    this.itemBuilder,
    this.indexedItemBuilder,
    this.keySelector,
    required this.crossAxisCount,
    this.crossAxisSpacing = 0,
    this.childAspectRatio = 1.0,
    this.mainAxisCount,
    this.mainAxisExtent,
    this.mainAxisSpacing = 0,
    this.padding,
    this.controller,
    this.physics,
  });

  final List<T> items;

  final Widget Function(BuildContext context, T item)? itemBuilder;

  final Widget Function(BuildContext context, int index, T item)?
      indexedItemBuilder;

  final Object Function(T item)? keySelector;

  final int crossAxisCount;

  final int? mainAxisCount;

  final double? mainAxisExtent;

  final double childAspectRatio;

  final double mainAxisSpacing;

  final double crossAxisSpacing;

  final EdgeInsets? padding;

  final ScrollController? controller;

  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    final padding = this.padding ?? EdgeInsets.zero;
    return ReorderableBuilder(
      scrollController: controller,
      enableDraggable: false,
      enableScrollingWhileDragging: false,
      children: [
        ...items.mapIndexed(
          (index, item) => KeyedSubtree(
            key: ValueKey(keySelector?.call(item) ?? item),
            child: indexedItemBuilder?.call(context, index, item) ??
                itemBuilder!.call(context, item),
          ),
        )
      ],
      builder: (children) => LayoutBuilder(builder: (context, constraint) {
        double? mainAxisExtent;
        if (mainAxisCount != null) {
          mainAxisExtent = (constraint.maxHeight -
                  (padding.top + padding.bottom) -
                  (mainAxisCount! - 1) * mainAxisSpacing) /
              mainAxisCount!;
        } else {
          mainAxisExtent = this.mainAxisExtent;
        }
        return GridView(
          padding: padding,
          controller: controller,
          physics: physics,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: mainAxisSpacing,
              crossAxisSpacing: crossAxisSpacing,
              mainAxisExtent: mainAxisExtent,
              childAspectRatio: childAspectRatio),
          children: children,
        );
      }),
    );
  }
}
