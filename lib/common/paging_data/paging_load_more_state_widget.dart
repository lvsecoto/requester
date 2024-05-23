import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visibility_detector/visibility_detector.dart';

// ignore: implementation_imports
import 'package:riverpod/src/notifier.dart';

import '../common.dart';

class PagingLoadMoreStateWidget<Notifier extends PagingLoadNotifierMixin>
    extends ConsumerWidget {
  /// 放在列表底部，用来控制加载更多、显示加载更多状态
  const PagingLoadMoreStateWidget({
    super.key,
    required this.pagingLoadProvider,
  });

  /// 加载更多的[StateNotifier]
  // ignore: invalid_use_of_internal_member
  final NotifierProviderBase<Notifier, PagingLoadState>
      pagingLoadProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoadingMore =
        ref.watch(pagingLoadProvider.select((it) => it.isLoadingMore));
    final hasMore = ref.watch(pagingLoadProvider.select((it) => it.hasMore));

    Widget child;
    if (hasMore) {
      child = VisibilityDetector(
        key: Key(pagingLoadProvider.toString()),
        onVisibilityChanged: (it) {
          if(it.visibleFraction == 1.0) {
            ref.read(pagingLoadProvider.notifier).loadMore();
          }
        },
        child: AnimatedVisibilityWidget(
          animationWidgetBuilder: AnimatedVisibilityWidget.fadeAnimationWidgetBuilder,
          duration: kThemeAnimationDuration * 2,
          isVisible: isLoadingMore,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox.square(
                dimension: 48,
                child: isLoadingMore ? const CircularProgressIndicator() : null,
              ),
            ),
          ),
        ),
      );
    } else {
      child = const SizedBox.shrink();
    }

    return SliverToBoxAdapter(
      child: AnimatedSizeAndFade(
        childKey: hasMore,
        child: child,
      ),
    );
  }
}
