import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:requester/domain/document/document.dart';
import 'package:requester/ui/common/common.dart';
import 'package:requester/ui/settings/document/provider/provider.dart'
    as provider;

class ActionDeleteDocumentSourceWidget extends ConsumerWidget {
  /// 操作删除文档源头
  const ActionDeleteDocumentSourceWidget({
    super.key,
    required this.source,
  });

  final DocumentSource source;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () async {
        final confirmed = await showConfirmDialog(
          context,
          title: const Text('删除文档源'),
        );
        if (confirmed) {
          await provider.actionRemoveDocumentSource(ref, source);
        }
      },
      icon: const Icon(Icons.close),
    );
  }
}
