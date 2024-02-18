part of 'document.dart';

typedef DocumentSourceListProvider
    = AutoDisposeNotifierProvider<DocumentSourceList, List<DocumentSource>?>;

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

/// 文档库
@riverpod
class ApiDocumentsStore extends _$ApiDocumentsStore {
  @override
  Future<Map<DocumentSource, APIDocument>> build() async {
    final sources =
        await ref.watch(documentManagerProvider)._persistence.getSources();
    final documents = await Future.wait(sources.map((source) async {
      final data = (await Dio().get(source.url)).data;
      return MapEntry(
        source,
        APIDocument.fromMap(data),
      );
    }));
    return Map.fromEntries(documents);
  }
}

typedef _AnalyzeLogRequestDocument = ({
  APIOperation apiOperation,
  APIPath apiPath,
  DocumentSource documentSource
});

/// 根据[path]查找文档
@riverpod
class AnalyzeLogRequest extends _$AnalyzeLogRequest {
  @override
  Future<LogRequestAnalysis?> build(Log logRequest) async {
    if (logRequest is! LogRequest) {
      throw '';
    }

    final documentsStore = await ref.watch(apiDocumentsStoreProvider.future);
    final document = _findDocument(documentsStore, logRequest);

    if (document == null) {
      return null;
    }

    return LogRequestAnalysis(
      documentSource: document.documentSource,
      summary: [document.apiOperation.summary, document.apiPath.summary]
          .filterNotNull()
          .join('\n'),
      queries: _analyzeFields(
        document,
        APIParameterLocation.query,
      ),
      headers: _analyzeFields(
        document,
        APIParameterLocation.header,
      ),
      requestBody: ObjectAnalysis(
        scheme: document
                .apiOperation.requestBody?.content?.values.firstOrNull?.schema ??
            APISchemaObject.empty(),
      ),
      responseBody: document.apiOperation.responses?.map(
        (key, response) => MapEntry(
          key,
          ObjectAnalysis(
            scheme: response?.content?.values.firstOrNull?.schema ??
                APISchemaObject.empty(),
          ),
        ),
      ),
    );
  }

  Map<String, FieldAnalysis> _analyzeFields(
    _AnalyzeLogRequestDocument document,
    APIParameterLocation location,
  ) {
    return [
      ...document.apiPath.parameters
          .filterNotNull()
          .filter((it) => it.location == location),
      ...document.apiOperation.parameters
              ?.filterNotNull()
              .filter((it) => it.location == location)
              .toList() ??
          const [],
    ].associate(
      (it) => MapEntry(
          it.name ?? '',
          FieldAnalysis(
            documentSource: document.documentSource,
            parameterDocument: it,
          )),
    );
  }

  _AnalyzeLogRequestDocument? _findDocument(
    Map<DocumentSource, APIDocument> documentsStore,
    LogRequest logRequest,
  ) {
    final url = Uri.parse(logRequest.requestPath).path;
    final method = logRequest.requestMethod.toUpperCase();
    return documentsStore.entries.flatMap((sourceAndDoc) {
      final keyAndPaths = sourceAndDoc.value.paths?.entries.toList() ?? [];
      // 从Path中迭代Operation（Method），进而匹配合适的Path和Operation
      return keyAndPaths.mapNotNull((keyAndPath) {
        final path = keyAndPath.key;
        if (!RegExp('.+/${path.removePrefix('/')}').hasMatch(url)) {
          return null;
        }
        final operation = keyAndPath.value?.operations.entries
            .firstOrNullWhere(
                (it) => it.key.toUpperCase() == method.toUpperCase())
            ?.value;

        if (operation == null) {
          return null;
        }

        return (
          documentSource: sourceAndDoc.key,
          apiPath: keyAndPath.value!,
          apiOperation: operation,
        );
      });
    }).firstOrNull;
  }
}
