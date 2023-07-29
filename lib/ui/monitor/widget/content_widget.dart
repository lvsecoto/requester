import 'package:flutter/material.dart';
import 'package:requester/app/theme/theme.dart';
import 'package:requester/domain/client/client.dart';
import 'package:requester/ui/monitor/widget/request/request_list_widget.dart';

class ContentWidget extends StatelessWidget {
  const ContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchBar(
          hintText: '搜索请求',
          elevation: MaterialStatePropertyAll(4),
        ),
        SizedBox(height: 16),
        ButtonBar(
          children: [
            ElevatedButton(
                onPressed: () {
                  TestClient().test();
                },
                child: Text('测试')),
          ],
        ),
        SizedBox(height: 16),
        Expanded(
          child: Material(
            color: AppTheme.of(context).surfaceContainerLow,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: RequestListWidget(),
          ),
        ),
      ],
    );
  }
}
