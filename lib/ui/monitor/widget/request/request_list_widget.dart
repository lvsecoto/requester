import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:requester/domain/log/log.dart';
import 'package:requester/route/route.dart';
import 'package:requester/ui/monitor/provider/provider.dart' as provider;

import 'item/item.dart';

class RequestListWidget extends ConsumerWidget {
  const RequestListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listProvider = provider.watchLogProvider(ref);
    final request = ref.watch(listProvider).data;
    return CustomScrollView(
      slivers: [
        DiffSliverAnimatedList(
            items: request,
            keySelector: (it) => it.id,
            indexedItemBuilder: (context, item, index) => Column(
                  children: [
                    if (index != 0)
                      const Divider(indent: 16, endIndent: 16, height: 1),
                    switch (item) {
                      LogRequest() => _RequestItem(
                          item: item,
                          index: index,
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
    required this.index,
  });

  final LogRequest item;

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentId = GoRouterState.of(context).pathParameters['requestId'];
    return Material(
      animationDuration: const Duration(seconds: 1),
      color:
          item.id == currentId || (index == 0 && kLatestRequestId == currentId)
              ? Theme.of(context).colorScheme.primaryContainer
              : Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () async {
          final int targetRequestId;
          if (index == 0) {
            targetRequestId = kLatestRequestId;
          } else {
            targetRequestId = item.id;
          }
          // await ref.watch(getMonitorRequestProvider(targetRequestId).future);
          // if (context.mounted) {
          //   RequestRoute(targetRequestId).go(context);
          // }
        },
        child: RequestItemWidget(
          request: item,
        ),
      ),
    );
  }
}
