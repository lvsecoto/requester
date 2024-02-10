import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:requester/app/theme/theme.dart';
import 'package:requester/ui/client/details/provider/provider.dart' as provider;

class LogInfoWidget extends StatelessWidget {
  const LogInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      color: AppTheme.of(context).surfaceContainerHigh,
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              title: const Text('日志上报目标'),
              subtitle: HookConsumer(builder: (context, ref, _) {
                final hostPort = ref
                        .watch(provider.loadClientLogHostPortProvider)
                        .valueOrNull
                        ?.encode() ??
                    '';
                return Text(hostPort);
              }),
            ),
          ),
          Consumer(builder: (context, ref, _) {
            final isBindToSelf =
                ref.watch(provider.loadIsClientLogToSelfProvider).valueOrNull;
            final enabled = isBindToSelf == null || isBindToSelf;
            return FilledButton(
              onPressed: enabled
                  ? null
                  : () {
                      provider.actionBindClientLogHostPortToSelf(ref);
                    },
              child: const Text('绑定'),
            );
          }),
          const Gap(16),
        ],
      ),
    );
  }
}
