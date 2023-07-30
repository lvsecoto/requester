import 'package:common/common.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:requester/domain/monitor/provider.dart';
import 'package:requester/route/route.dart';

import 'item/item.dart';

class RequestListWidget extends ConsumerWidget {
  const RequestListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final request = ref.watch(monitorRequestListProvider).valueOrNull ?? [];
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          sliver: DiffSliverAnimatedList(
            items: request,
            keySelector: (item) => item.id,
            indexedItemBuilder: (context, item, index) => Column(
              children: [
                InkWell(
                  onTap: () async {
                    await ref.watch(getMonitorRequestProvider(item.id).future);
                    if (context.mounted) {
                      RequestRoute(item.id).go(context);
                    }
                  },
                  child: RequestItemWidget(
                    request: item,
                  ),
                ),
                if (index != request.lastIndex)
                  const Divider(indent: 16, endIndent: 16, height: 0),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
