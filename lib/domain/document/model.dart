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
