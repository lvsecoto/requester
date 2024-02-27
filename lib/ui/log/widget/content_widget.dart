import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'actions/actions.dart';
import 'log_search_bar.dart';
import 'request/request.dart';

class ContentWidget extends HookConsumerWidget {
  const ContentWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        LogSearchBar(),
        SizedBox(height: 16),
        Row(
          children: [
            Spacer(),
            ActionClearLogs(),
          ],
        ),
        SizedBox(height: 8),
        Expanded(
          child: RequestListWidget(),
        ),
      ],
    );
  }
}
