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
            IconButton.outlined(
              onPressed: () {
                ref.read(monitorRequestListProvider.notifier).addDivider();
              },
              icon: const Icon(Icons.vertical_align_center_outlined),
            ),
            const SizedBox(width: 8),
            IconButton.outlined(
              onPressed: () {
                TestClient().test();
                TestClient().testGet();
                TestClient().testPost();
              },
              icon: const Icon(Icons.network_ping),
              tooltip: '测试',
            ),
          ],
        ),
        const SizedBox(height: 8),
        Expanded(
          child: const RequestListWidget(),
        ),
      ],
    );
  }
}
