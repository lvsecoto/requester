import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:requester/ui/client/details/provider/provider.dart' as provider;
import 'package:requester/ui/common/common.dart';

class ClientInfosWidget extends ConsumerWidget {
  const ClientInfosWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final infos =
        ref.watch(provider.observeClientInfoProvider).valueOrNull?.entries ??
            [];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...infos.map(
          (info) => ListTile(
            onTap: () {},
            title: Text(info.key),
            subtitle: Text(info.value),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                final value = await showInputDialog(context);
                if (value != null) {
                  provider.actionUpdateClientInfoEntry(
                    ref,
                    key: info.key,
                    value: value,
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
