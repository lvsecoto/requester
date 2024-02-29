import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:requester/domain/log/log.dart';
import 'package:requester/router.dart';
import 'package:requester/ui/log/provider/provider.dart' as provider;

import 'item/item.dart';

class LogListWidget extends HookConsumerWidget {
  const LogListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listProvider = ref.watch(provider.watchLogProviderProvider);
    final requests = ref.watch(listProvider).data;

    ref.listen(listProvider.select((it) => it.data.firstOrNull), (prev, next) {
      final currentPath = GoRouterState.of(context).uri.toString();
      if ((prev != null && currentPath == LogDetailsRoute(prev.id).location) &&
          next != null) {
        LogDetailsRoute(next.id).go(context);
      }
    });

    return CustomScrollView(
      slivers: [
        DiffSliverAnimatedList(
            items: requests,
            keySelector: (it) => it.id,
            indexedItemBuilder: (context, item, index) => Column(
                  children: [
                    if (index != 0)
                      const Divider(indent: 16, endIndent: 16, height: 1),
                    switch (item) {
                      LogRequest() => _RequestItem(
                          item: item,
                          onTap: () async {
                            LogDetailsRoute(item.id).go(context);
                          },
                        ),
                      _ => throw '',
                    },
                  ],
                )),
        PagingLoadMoreStateWidget(
          pagingLoadProvider: listProvider,
        ),
      ],
    );
  }
}

class _RequestItem extends ConsumerWidget {
  const _RequestItem({
    required this.item,
    required this.onTap,
  });

  final LogRequest item;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentId = LogDetailsRoute.from(GoRouterState.of(context))?.id;
    return Material(
      animationDuration: const Duration(seconds: 1),
      color: item.id == currentId
          ? Theme.of(context).colorScheme.primaryContainer
          : Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        child: LogRequestItemWidget(
          logRequest: item,
        ),
      ),
    );
  }
}