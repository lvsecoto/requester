part of 'document.dart';

@freezed
class DocumentSource with _$DocumentSource {
  const factory DocumentSource({
    required String url,
    required String name,
  }) = _DocumentSource;

  factory DocumentSource.fromJson(Map<String, dynamic> json) =>
      _$DocumentSourceFromJson(json);
}

@freezed
class LogRequestAnalysis with _$LogRequestAnalysis {
  /// 请求日志分析结果
  const factory LogRequestAnalysis({
    required DocumentSource documentSource,

    /// 总览
    required String summary,

    /// 查询字段
    required Map<String, FieldAnalysis> queries,

    /// 头字段
    required Map<String, FieldAnalysis> headers,

    /// 请求字段
    ObjectAnalysis? requestBody,

    /// 返回字段(String代表不同的返回代码)
    Map<String, ObjectAnalysis>? responseBody,
  }) = _LogRequestAnalysis;
}

@freezed
class FieldAnalysis with _$FieldAnalysis {
  const FieldAnalysis._();

  /// 字段分析
  const factory FieldAnalysis({
    required DocumentSource documentSource,

    /// 文档
    required APIParameter parameterDocument,
  }) = _FieldAnalysis;

  /// 总览
  String get summary => parameterDocument.description ?? '';

  /// 分析数值
  FieldAnalysisResult analyzeData(dynamic data) {
    if (data == null) {
      if (parameterDocument.isRequired ?? false) {
        return const FieldAnalysisResult.missed();
      } else {
        return const FieldAnalysisResult.corrected();
      }
    }

    final enumerated =
        parameterDocument.schema?.enumerated?.map((it) => it.toString());
    if (enumerated != null) {
      if (enumerated.contains(data.toString())) {
        return const FieldAnalysisResult.corrected();
      } else {
        return FieldAnalysisResult.typeError(
          expected: '${enumerated.join(',')}其中之一',
          butWas: data.toString(),
        );
      }
    }

    final type = parameterDocument.schema?.type;
    switch (type) {
      case null:
        return const FieldAnalysisResult.corrected();
      case APIType.number:
      case APIType.integer:
        return int.tryParse(data.toString()) != null
            ? const FieldAnalysisResult.corrected()
            : FieldAnalysisResult.typeError(
                expected: '数字',
                butWas: data.toString(),
              );
      case APIType.array:
        return tryJsonDecode(data.toString()) is List
            ? const FieldAnalysisResult.corrected()
            : FieldAnalysisResult.typeError(
                expected: '列表',
                butWas: data.toString(),
              );
      case APIType.object:
        return tryJsonDecode(data.toString()) is Map
            ? const FieldAnalysisResult.corrected()
            : FieldAnalysisResult.typeError(
                expected: '对象',
                butWas: data.toString(),
              );
      case APIType.boolean:
        return ['true', 'false'].contains(data.toString())
            ? const FieldAnalysisResult.corrected()
            : FieldAnalysisResult.typeError(
                expected: 'true,false',
                butWas: data.toString(),
              );
      case APIType.string:
        return const FieldAnalysisResult.corrected();
    }
  }
}

@freezed
sealed class FieldAnalysisResult with _$FieldAnalysisResult {
  /// 正确
  const factory FieldAnalysisResult.corrected() = FieldAnalysisResultCorrected;

  /// 参数丢失
  const factory FieldAnalysisResult.missed() = FieldAnalysisResultMissed;

  /// 类型错误
  const factory FieldAnalysisResult.typeError({
    required String expected,
    required String butWas,
  }) = FieldAnalysisResultTypeError;
}

@freezed
class ObjectAnalysis with _$ObjectAnalysis {
  const ObjectAnalysis._();

  const factory ObjectAnalysis({
    required APISchemaObject scheme,
  }) = _ObjectAnalysis;

  ObjectAnalysisResult analyze(dynamic data) {
    ObjectAnalysisResult inflate(
      dynamic key,
      APISchemaObject? scheme,
      dynamic data,
    ) {
      if (data is Map<String, dynamic>) {
        final fields = [
          ...data.mapEntries((entry) {
            final fieldScheme = scheme?.properties?[entry.key];
            final fieldData = entry.value;
            return inflate(entry.key, fieldScheme, fieldData);
          }),
          // 漏了的字段
          ...(scheme?.properties ?? const {})
              .filterNot((it) => data.containsKey(it.key))
              .mapEntries(
                (fieldSchemeEntry) =>
                    inflate(fieldSchemeEntry.key, fieldSchemeEntry.value, null),
              ),
        ];
        if (scheme == null) {
          return ObjectAnalysisResult.redundant(
            key: key,
            fields: fields,
          );
        } else if (scheme.type != APIType.object) {
          return ObjectAnalysisResult.missed(
            key: key,
            expected: _getExpectedType(scheme.type, data) ?? '',
            busWas: data.toString(),
            fields: fields,
          );
        } else {
          return ObjectAnalysisResult.corrected(
            key: key,
            summary: scheme.description ?? '',
            fields: fields,
          );
        }
      } else if (data is List) {
        final fields = data
            .mapIndexed(
              (index, data) => inflate(index, scheme?.items, data),
            )
            .toList();
        if (scheme == null) {
          return ObjectAnalysisResult.redundant(
            key: key,
            fields: fields,
          );
        } else if (scheme.type != APIType.array) {
          return ObjectAnalysisResult.missed(
            key: key,
            expected: _getExpectedType(scheme.type, data) ?? '',
            busWas: data.toString(),
            fields: fields,
          );
        } else {
          return ObjectAnalysisResult.corrected(
            key: key,
            summary: scheme.description ?? '',
            fields: fields,
          );
        }
      } else {
        if (scheme == null) {
          return ObjectAnalysisResult.redundant(
            key: key,
            value: data,
            fields: const [],
          );
        } else {
          final expected = _getExpectedType(scheme.type, data);
          if (expected != null) {
            List<ObjectAnalysisResult> fields = const [];
            if (scheme.type == APIType.object) {
              // 漏了的字段
              fields = (scheme.properties ?? const {})
                  .mapEntries(
                    (fieldSchemeEntry) => inflate(
                        fieldSchemeEntry.key, fieldSchemeEntry.value, null),
                  )
                  .toList();
            } else if (scheme.type == APIType.array) {
              fields = [
                inflate(key, scheme.items, null),
              ];
            }
            return ObjectAnalysisResult.missed(
              key: key,
              value: data,
              expected: expected,
              busWas: data.toString(),
              fields: fields,
            );
          } else {
            return ObjectAnalysisResult.corrected(
              key: key,
              value: data,
              summary: scheme.description ?? '',
              fields: const [],
            );
          }
        }
      }
    }

    return inflate(null, scheme, data);
  }

  /// 返回期望对象，如果[fieldData]符合期望对象，则返回为空
  String? _getExpectedType(APIType? fieldType, fieldData) {
    return switch (fieldType) {
      null => null,
      APIType.array => tryJsonDecode(fieldData) is List ? null : '列表',
      APIType.object => tryJsonDecode(fieldData) is Map ? null : '对象',
      APIType.string => fieldData is String ? null : 'string',
      APIType.number => fieldData is int ? null : 'int',
      APIType.integer => fieldData is int ? null : 'int',
      APIType.boolean => fieldData is bool ? null : 'bool',
    };
  }
}

@freezed
sealed class ObjectAnalysisResult with _$ObjectAnalysisResult {
  const factory ObjectAnalysisResult.corrected({
    required dynamic key,
    dynamic value,
    required String summary,
    required List<ObjectAnalysisResult>? fields,
  }) = ObjectAnalysisResultCorrected;

  const factory ObjectAnalysisResult.redundant({
    required dynamic key,
    dynamic value,
    required List<ObjectAnalysisResult>? fields,
  }) = ObjectAnalysisResultRedundant;

  const factory ObjectAnalysisResult.missed({
    required dynamic key,
    dynamic value,
    required String expected,
    required String busWas,
    required List<ObjectAnalysisResult>? fields,
  }) = ObjectAnalysisResultMissed;
}
