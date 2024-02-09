import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'widget/content_widget.dart';

class RequesterClientListScreen extends HookConsumerWidget {

  /// Requester客户端列表界面
  const RequesterClientListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const ContentWidget();
  }
}
