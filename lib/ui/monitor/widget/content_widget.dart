import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:requester/app/theme/theme.dart';
import 'package:requester/domain/client/client.dart';
import 'package:requester/domain/monitor/monitor.dart';
import 'package:requester/domain/monitor/provider.dart';
import 'package:requester/ui/monitor/provider/provider.dart';
import 'package:requester/ui/monitor/widget/request/request_list_widget.dart';

class ContentWidget extends HookConsumerWidget {
  const ContentWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logMonitor = ref.watch(monitorProvider);
    bool isAppForeground(AppLifecycleState? appState) {
      return [AppLifecycleState.inactive, AppLifecycleState.resumed]
          .contains(appState);
    }
    useOnAppLifecycleStateChange((previous, next) {
      if (!isAppForeground(previous) && isAppForeground(next)) {
        logMonitor.start();
      } else if (isAppForeground(previous) && !isAppForeground(next)) {
        logMonitor.stop();
      }
    });

    return Column(
      children: [
        Consumer(
          builder: (context, ref, child) => Material(
            color: AppTheme.of(context).surfaceContainerLow,
            elevation: 1,
            shape: const StadiumBorder(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: TextField(
                decoration: const InputDecoration.collapsed(
                  hintText: '搜索请求',
                ),
                controller: ref.watch(editQueryProvider.notifier).controller,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            IconButton(
              onPressed: () {
                ref.read(monitorRequestListProvider.notifier).addDivider();
              },
              icon: const Icon(Icons.vertical_align_center_outlined),
            ),
            const SizedBox(width: 8),
            Consumer(builder: (context, ref, _) {
              final testClient = ref.watch(testClientProvider);
              return IconButton(
                onPressed: () {
                  testClient.test();
                  testClient.testGet();
                  testClient.testPost();
                },
                icon: const Icon(Icons.network_ping),
                tooltip: '测试',
              );
            }),
            const Spacer(),
            IconButton.outlined(
              onPressed: () async {
                final confirmed = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text('清除所有记录'),
                          content: const Text('请确认清除操作'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('取消'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                              child: const Text('确认清除'),
                            ),
                          ],
                        ));

                if (confirmed == true) {
                  ref.read(monitorRequestListProvider.notifier).clean();
                }
              },
              icon: const Icon(Icons.cleaning_services),
              tooltip: '清除',
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Expanded(
          child: RequestListWidget(),
        ),
      ],
    );
  }
}
