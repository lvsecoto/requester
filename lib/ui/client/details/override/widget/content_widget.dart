import 'package:common/common.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:requester/ui/client/details/override/provider/provider.dart'
    as provider;
import 'package:requester/ui/client/details/override/widget/overridden_item_widget.dart';
import 'package:requester/ui/common/common.dart';

import '../edit/edit.dart';

class ContentWidget extends ConsumerWidget {
  const ContentWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('请求重载'),
        actions: [
          IconButton(
            onPressed: () async {
              final override = await showOverrideRequestDialog(context);
              if (override != null) {
                await provider.actionAddOverrideRequest(
                  ref,
                  override,
                );
              }
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          Consumer(builder: (context, ref, _) {
            final items =
                ref.watch(provider.overrideRequestListProvider).valueOrNull ??
                    [];
            return DiffSliverAnimatedList(
              items: items,
              keySelector: (item) => item.id!,
              itemBuilder: (context, item) => OverriddenItemWidget(overrideRequest: item),
            );
          }),
        ],
      ),
    );
  }
}
