import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:requester/common/responsive_layout/dialog.dart';
import 'package:requester_client/requester_client.dart';

import 'widget/content_widget.dart';

class RequesterClientListScreen extends HookConsumerWidget {
  /// Requester客户端列表界面
  const RequesterClientListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const ContentWidget();
  }
}

Future<RequesterClient?> showRequestClientListDialog(
    BuildContext context) {
  return showResponsiveDialog<RequesterClient>(
    context,
    isContentScrollable: true,
    title: const Text('设备列表'),
    body: Builder(
      builder: (context) {
        return DialogContentWidget(
          onSelect: (client) {
            Navigator.of(context).pop(client);
          },
        );
      }
    ),
  );
}
