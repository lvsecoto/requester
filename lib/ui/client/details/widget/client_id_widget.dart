import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:requester/app/theme/theme.dart';
import 'package:requester/ui/client/details/provider/provider.dart' as provider;
import 'package:requester/ui/common/common.dart';

class ClientIdWidget extends ConsumerWidget {
  const ClientIdWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      color: AppTheme.of(context).surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Expanded(
              child: _ClientId(),
            ),
            FilledButton(
              onPressed: () {
                provider.actionIdentityClient(ref);
              },
              child: const Text('识别'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ClientId extends ConsumerWidget {
  const _ClientId({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            ref.watch(provider.loadClientIdProvider).valueOrNull ?? '',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        const Gap(8),
        IconButton(
          icon: const Icon(
            Icons.edit,
            size: 16,
          ),
          onPressed: () async {
            final clientId = await showInputDialog(
              context,
              title: const Text('输入客户端id'),
            );
            if (clientId != null) {
              provider.actionUpdateClientId(ref, clientId: clientId);
            }
          },
        ),
      ],
    );
  }
}
