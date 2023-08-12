import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:requester/domain/client/client.dart';
import 'package:requester/domain/monitor/provider.dart';
import 'package:requester/ui/monitor/provider/provider.dart';
import 'package:requester/ui/monitor/widget/request/request_list_widget.dart';

class ContentWidget extends ConsumerWidget {
  const ContentWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Consumer(
          builder: (context, ref, child) => SearchBar(
            shadowColor: const MaterialStatePropertyAll(Colors.transparent),
            hintText: '搜索请求',
            elevation: const MaterialStatePropertyAll(4),
            controller: ref.watch(editQueryProvider.notifier).controller,
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
            IconButton(
              onPressed: () {
                TestClient().test();
                TestClient().testGet();
                TestClient().testPost();
              },
              icon: const Icon(Icons.network_ping),
              tooltip: '测试',
            ),
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
