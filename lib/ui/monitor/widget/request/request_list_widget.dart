import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:requester/domain/monitor/provider.dart';

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
          padding: const EdgeInsets.symmetric(vertical: 16),
          sliver: DiffSliverAnimatedList(
            items: request,
            itemBuilder: (context, item) {
              return ListTile(
                title: Text(item.toString()),
              );
            },
          ),
        ),
      ],
    );
  }
}
