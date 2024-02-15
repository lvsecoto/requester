import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:requester/domain/document/document.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@riverpod
String document(DocumentRef ref) {
  return 'document';
}

DocumentSourceListProvider watchDocumentProvider(WidgetRef ref) {
  return ref.watch(documentManagerProvider).provideDocumentSourceList;
}

Future<void> actionAddDocumentSource(WidgetRef ref, String url) async {
  await ref.read(documentManagerProvider).addSource(url);
}

Future<void> actionRemoveDocumentSource(WidgetRef ref, DocumentSource source) async {
  await ref.read(documentManagerProvider).removeSource(source);
}
