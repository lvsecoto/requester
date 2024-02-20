import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:requester/ui/client/details/override/provider/provider.dart'
    as provider;
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
              itemBuilder: (context, item) => ListTile(
                title: Text(item.matcher.path),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () async {
                        final override = await showOverrideRequestDialog(context, overrideRequest: item);
                        if (override != null) {
                          provider.actionUpdateOverrideRequest(ref, override);
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () async {
                        final confirmed = await showConfirmDialog(context, title: const Text('确认删除?'));
                        if (confirmed) {
                          provider.actionRemoveOverrideRequest(ref, item);
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
