import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:requester/app/theme/theme.dart';
import 'package:requester/common/common.dart';
import 'package:requester/ui/client/details/provider/provider.dart' as provider;
import 'package:requester/ui/common/common.dart';

class ClientInfosWidget extends ConsumerWidget {
  const ClientInfosWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final infos =
        ref.watch(provider.observeClientInfoProvider).valueOrNull?.entries ??
            [];
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 12, right: 16),
      child: Material(
        color: AppTheme.of(context).surfaceContainerHigh,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
              child: Text(
                '运行参数',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            ...infos.map(
              (info) => ListTile(
                onTap: () {
                  copyToClipBoard(context, info.value);
                },
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
        ),
      ),
    );
  }
}
