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
  const factory FieldAnalysis({
    required DocumentSource documentSource,
    /// 总览
    required String summary,
  }) = _FieldAnalysis;
}

