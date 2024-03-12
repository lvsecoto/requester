// ignore_for_file: unused_import

import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
    final logsProvider = ref.watch(provider.watchLogProviderProvider);
    final logs = ref.watch(logsProvider).data;

    // 实现自动切换至最新日志
    ref.listen(logsProvider.select((it) => it.data.firstOrNull), (prev, next) {
      final currentPath = GoRouterState.of(context).uri.toString();
      if ((prev != null && currentPath == LogDetailsRoute(prev.id).location) &&
          next != null) {
        LogDetailsRoute(next.id).go(context);
      }
    });

    return CustomScrollView(
      slivers: [
        DiffSliverAnimatedList(
            items: logs,
            keySelector: (it) => it.id,
            indexedItemBuilder: (context, log, index) {
              var isFirstItem = index == 0;
              final isBetweenLogRequest = !isFirstItem &&
                  (logs.elementAtOrNull(index - 1) is LogRequest ||
                      logs.elementAtOrNull(index) is LogRequest);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (!isFirstItem && isBetweenLogRequest)
                    const Divider(indent: 16, endIndent: 16, height: 1),
                  LogItemWidget(log: log),
                ],
              );
            }),
        PagingLoadMoreStateWidget(
          pagingLoadProvider: logsProvider,
        ),
      ],
    );
  }
}
