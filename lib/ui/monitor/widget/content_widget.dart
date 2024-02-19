import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:requester/app/theme/theme.dart';
import 'package:requester/ui/monitor/provider/provider.dart' as provider;
import 'package:requester/ui/monitor/widget/request/request_list_widget.dart';

class ContentWidget extends HookConsumerWidget {
  const ContentWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const Gap(2),
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
                controller: ref.watch(provider.editQueryProvider.notifier).controller,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
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
                  provider.actionClearLog(ref);
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
