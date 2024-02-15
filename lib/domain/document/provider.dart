part of 'document.dart';

typedef DocumentSourceListProvider = AutoDisposeNotifierProvider<
    DocumentSourceList, List<DocumentSource>?>;

@riverpod
class DocumentSourceList extends _$DocumentSourceList with StreamValueNotifier {
  @override
  List<DocumentSource>? build() {
    return onBuild();
  }

  @override
  Stream<List<DocumentSource>> buildStream() {
    return ref.watch(documentManagerProvider)._sources;
  }
}
