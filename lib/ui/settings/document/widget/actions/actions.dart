import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:requester/common/common.dart';
import 'package:requester/domain/document/document.dart';
import 'package:requester/ui/common/common.dart';
import 'package:requester/ui/settings/document/provider/provider.dart'
    as provider;

export 'action_sync_document_source_widget.dart';

enum _Action {
  /// 复制
  copy('复制'),

  /// 删除
  delete('删除'),
  ;

  final String title;

  const _Action(this.title);
}

/// 显示文档上下文菜单
Future<void> showDocumentContextActions(
    WidgetRef ref, provider.DocumentSource source) async {
  final result = await showOptionsDialog(
    ref.context,
    options: _Action.values,
    optionBuilder: (context, item, onTap) => ListTile(
      title: Text(item.title),
      onTap: () {
        onTap(item);
      },
    ),
  );

  switch (result) {
    case _Action.copy:
      _actionCopyDocument(ref, source);
      break;
    case _Action.delete:
      _actionDeleteDocument(ref, source);
      break;
    case null:
      break;
  }
}

/// 操作：删除文档源
Future<void> _actionDeleteDocument(WidgetRef ref, DocumentSource source) async {
  final confirmed = await showConfirmDialog(
    ref.context,
    title: const Text('删除文档源'),
  );
  if (confirmed) {
    await provider.actionDeleteDocumentSource(ref, source);
  }
}

/// 复制文档源
Future<void> _actionCopyDocument(WidgetRef ref, DocumentSource source) async {
  copyToClipBoard(ref.context, source.url);
}
