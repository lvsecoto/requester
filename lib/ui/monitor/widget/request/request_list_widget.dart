import 'package:common/common.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:requester/domain/monitor/provider.dart';
import 'package:requester/route/route.dart';
import 'package:requester/ui/monitor/provider/provider.dart';

import 'item/item.dart';

class RequestListWidget extends ConsumerWidget {
  const RequestListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final request = ref.watch(filteredRequestProvider).valueOrNull ?? [];
    final currentId = GoRouterState.of(context).pathParameters['requestId'];
    return CustomScrollView(
      slivers: [
        DiffSliverAnimatedList(
          items: request,
          keySelector: (item) => item.id,
          indexedItemBuilder: (context, item, index) => Column(
            children: [
              Material(
                animationDuration: const Duration(seconds: 1),
                color: item.id == currentId ||
                        (index == 0 && kLatestRequestId == currentId)
                    ? Theme.of(context).colorScheme.primaryContainer
                    : Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: InkWell(
                  onTap: () async {
                    final String targetRequestId;
                    if (index == 0) {
                      targetRequestId = kLatestRequestId;
                    } else {
                      targetRequestId = item.id;
                    }
                    await ref.watch(
                        getMonitorRequestProvider(targetRequestId).future);
                    if (context.mounted) {
                      RequestRoute(targetRequestId).go(context);
                    }
                  },
                  child: RequestItemWidget(
                    request: item,
                  ),
                ),
              ),
              if (index != request.lastIndex)
                const Divider(indent: 16, endIndent: 16, height: 0),
            ],
          ),
        ),
      ],
    );
  }
}
