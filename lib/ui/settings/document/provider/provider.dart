import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:requester/domain/document/document.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@riverpod
String document(DocumentRef ref) {
  return 'document';
}

/// 获取文档列表Provider
DocumentSourceListProvider watchDocumentProvider(WidgetRef ref) {
  return ref.watch(documentManagerProvider).provideDocumentSourceList;
}

/// 添加文档源
Future<void> actionAddDocumentSource(WidgetRef ref, String url) async {
  await ref.read(documentManagerProvider).addSource(url);
}

/// 删除文档源
Future<void> actionRemoveDocumentSource(WidgetRef ref, DocumentSource source) async {
  await ref.read(documentManagerProvider).removeSource(source);
}

/// 同步文档源
Future<void> actionSyncDocumentSource(WidgetRef ref, DocumentSource source) async {
  await ref.read(documentManagerProvider).syncSource(source);
}
