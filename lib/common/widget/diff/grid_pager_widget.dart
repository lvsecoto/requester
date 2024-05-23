import 'package:flutter/material.dart';
import 'animated_grid_view.dart';

class DiffGridPagerWidget<T> extends StatelessWidget {
  /// 输入一个数据列表，在可左右切换的表格列表中展示
  const DiffGridPagerWidget({
    super.key,
    required this.items,
    required this.crossAxisCount,
    required this.mainAxisCount,
    this.mainAxisSpacing,
    this.crossAxisSpacing,
    this.itemBuilder,
    this.indexedItemBuilder,
    this.keySelector,
    this.padding,
    this.pageController,
  });

  final List<T> items;

  /// 横向多少个
  final int crossAxisCount;

  /// 纵向多少个
  final int mainAxisCount;

  final double? mainAxisSpacing;

  final double? crossAxisSpacing;

  /// 根据条目构建
  final Widget Function(BuildContext context, T item)? itemBuilder;

  /// 根据条目构建，带索引
  final Widget Function(BuildContext context, int index, T item)?
      indexedItemBuilder;

  final Object Function(T item)? keySelector;

  final EdgeInsets? padding;

  final PageController? pageController;

  @override
  Widget build(BuildContext context) {
    final itemCountPerPage = mainAxisCount * crossAxisCount;
    final pageCount = items.length ~/ itemCountPerPage +
        (items.length % itemCountPerPage == 0 ? 0 : 1);

    return PageView.builder(
      itemCount: pageCount,
      controller: pageController,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, pageIndex) => DiffAnimatedGridView(
        items: items,
        padding: padding,
        mainAxisCount: mainAxisCount,
        mainAxisSpacing: mainAxisSpacing ?? 0,
        crossAxisSpacing: crossAxisSpacing ?? 0,
        crossAxisCount: crossAxisCount,
        physics: const NeverScrollableScrollPhysics(),
        keySelector: keySelector,
        indexedItemBuilder: (context, index, item) {
          final itemIndex = pageIndex * itemCountPerPage + index;
          final item = items.elementAtOrNull(itemIndex);
          if (item == null) return const SizedBox.expand();
          return indexedItemBuilder?.call(context, itemIndex, item) ??
              itemBuilder!.call(context, item);
        },
      ),
    );
  }
}
