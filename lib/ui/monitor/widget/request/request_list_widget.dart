import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:requester/domain/log/log.dart';
import 'package:requester/router.dart';
import 'package:requester/ui/monitor/provider/provider.dart' as provider;

import 'item/item.dart';

class RequestListWidget extends HookConsumerWidget {
  const RequestListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listProvider = provider.watchLogProvider(ref);
    final requests = ref.watch(listProvider).data;
    final alwaysShowLastLog = useState(false);
    if (alwaysShowLastLog.value) {
      ref.listen(listProvider.select((it) => it.data.firstOrNull), (_, next) {
        if (next != null) {
          RequestRoute(next.id).go(context);
        }
      });
    }

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
                          onTap: () {
                            alwaysShowLastLog.value = index == 0;
                            RequestRoute(item.id).go(context);
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
    final currentId = RequestRoute.from(GoRouterState.of(context))?.id;
    return Material(
      animationDuration: const Duration(seconds: 1),
      color: item.id == currentId
          ? Theme.of(context).colorScheme.primaryContainer
          : Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        child: RequestItemWidget(
          request: item,
        ),
      ),
    );
  }
}
