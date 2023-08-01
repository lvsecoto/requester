import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:requester/domain/client/client.dart';
import 'package:requester/ui/monitor/provider/provider.dart';
import 'package:requester/ui/monitor/widget/request/request_list_widget.dart';

class ContentWidget extends StatelessWidget {
  const ContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
            ElevatedButton(
              onPressed: () {
                TestClient().testGet();
              },
              child: const Text('测试Get'),),
            ElevatedButton(
              onPressed: () {
                TestClient().testPost();
              },
              child: const Text('测试Post'),),
            ElevatedButton(
              onPressed: () {
                TestClient().test();
              },
              child: const Text('测试'),),
          ],
        ),
        Expanded(
          child: const RequestListWidget(),
        ),
      ],
    );
  }
}
