import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:requester/domain/document/document.dart';
import 'package:requester/ui/settings/document/provider/provider.dart'
    as provider;

class ActionSyncDocumentSourceWidget extends ConsumerWidget {
  /// 操作删除文档源头
  const ActionSyncDocumentSourceWidget({
    super.key,
    required this.source,
  });

  final DocumentSource source;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () async {
        await provider.actionSyncDocumentSource(ref, source);
      },
      icon: const Icon(Icons.sync),
    );
  }
}
