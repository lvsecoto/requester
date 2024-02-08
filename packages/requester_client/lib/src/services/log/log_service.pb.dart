//
//  Generated code. Do not modify.
//  source: log/log_service.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// 请求日志
class LogRequest extends $pb.GeneratedMessage {
  factory LogRequest({
    $core.String? method,
    $core.String? path,
    $core.Map<$core.String, $core.String>? headers,
    $core.Map<$core.String, $core.String>? queries,
    $core.String? body,
  }) {
    final $result = create();
    if (method != null) {
      $result.method = method;
    }
    if (path != null) {
      $result.path = path;
    }
    if (headers != null) {
      $result.headers.addAll(headers);
    }
    if (queries != null) {
      $result.queries.addAll(queries);
    }
    if (body != null) {
      $result.body = body;
    }
    return $result;
  }
  LogRequest._() : super();
  factory LogRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LogRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LogRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'requester_client'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'method')
    ..aOS(2, _omitFieldNames ? '' : 'path')
    ..m<$core.String, $core.String>(3, _omitFieldNames ? '' : 'headers', entryClassName: 'LogRequest.HeadersEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('requester_client'))
    ..m<$core.String, $core.String>(4, _omitFieldNames ? '' : 'queries', entryClassName: 'LogRequest.QueriesEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('requester_client'))
    ..aOS(5, _omitFieldNames ? '' : 'body')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LogRequest clone() => LogRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LogRequest copyWith(void Function(LogRequest) updates) => super.copyWith((message) => updates(message as LogRequest)) as LogRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LogRequest create() => LogRequest._();
  LogRequest createEmptyInstance() => create();
  static $pb.PbList<LogRequest> createRepeated() => $pb.PbList<LogRequest>();
  @$core.pragma('dart2js:noInline')
  static LogRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LogRequest>(create);
  static LogRequest? _defaultInstance;

  /// 方法
  @$pb.TagNumber(1)
  $core.String get method => $_getSZ(0);
  @$pb.TagNumber(1)
  set method($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMethod() => $_has(0);
  @$pb.TagNumber(1)
  void clearMethod() => clearField(1);

  /// 路径
  @$pb.TagNumber(2)
  $core.String get path => $_getSZ(1);
  @$pb.TagNumber(2)
  set path($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPath() => $_has(1);
  @$pb.TagNumber(2)
  void clearPath() => clearField(2);

  /// 请求头
  @$pb.TagNumber(3)
  $core.Map<$core.String, $core.String> get headers => $_getMap(2);

  /// queries
  @$pb.TagNumber(4)
  $core.Map<$core.String, $core.String> get queries => $_getMap(3);

  /// 请求体
  @$pb.TagNumber(5)
  $core.String get body => $_getSZ(4);
  @$pb.TagNumber(5)
  set body($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasBody() => $_has(4);
  @$pb.TagNumber(5)
  void clearBody() => clearField(5);
}

enum LogResponse_Content {
  body, 
  reason, 
  notSet
}

/// 响应日志
class LogResponse extends $pb.GeneratedMessage {
  factory LogResponse({
    $core.int? code,
    $core.String? body,
    $core.String? reason,
    $core.Map<$core.String, $core.String>? headers,
  }) {
    final $result = create();
    if (code != null) {
      $result.code = code;
    }
    if (body != null) {
      $result.body = body;
    }
    if (reason != null) {
      $result.reason = reason;
    }
    if (headers != null) {
      $result.headers.addAll(headers);
    }
    return $result;
  }
  LogResponse._() : super();
  factory LogResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LogResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, LogResponse_Content> _LogResponse_ContentByTag = {
    3 : LogResponse_Content.body,
    4 : LogResponse_Content.reason,
    0 : LogResponse_Content.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LogResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'requester_client'), createEmptyInstance: create)
    ..oo(0, [3, 4])
    ..a<$core.int>(1, _omitFieldNames ? '' : 'code', $pb.PbFieldType.OU3)
    ..aOS(3, _omitFieldNames ? '' : 'body')
    ..aOS(4, _omitFieldNames ? '' : 'reason')
    ..m<$core.String, $core.String>(5, _omitFieldNames ? '' : 'headers', entryClassName: 'LogResponse.HeadersEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('requester_client'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LogResponse clone() => LogResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LogResponse copyWith(void Function(LogResponse) updates) => super.copyWith((message) => updates(message as LogResponse)) as LogResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LogResponse create() => LogResponse._();
  LogResponse createEmptyInstance() => create();
  static $pb.PbList<LogResponse> createRepeated() => $pb.PbList<LogResponse>();
  @$core.pragma('dart2js:noInline')
  static LogResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LogResponse>(create);
  static LogResponse? _defaultInstance;

  LogResponse_Content whichContent() => _LogResponse_ContentByTag[$_whichOneof(0)]!;
  void clearContent() => clearField($_whichOneof(0));

  /// 返回代码，一般是200
  /// 如果是-1，那么代表错误不是服务器返回的，而是客户端内部原因，比如：网络失去连接
  @$pb.TagNumber(1)
  $core.int get code => $_getIZ(0);
  @$pb.TagNumber(1)
  set code($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCode() => clearField(1);

  @$pb.TagNumber(3)
  $core.String get body => $_getSZ(1);
  @$pb.TagNumber(3)
  set body($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(3)
  $core.bool hasBody() => $_has(1);
  @$pb.TagNumber(3)
  void clearBody() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get reason => $_getSZ(2);
  @$pb.TagNumber(4)
  set reason($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(4)
  $core.bool hasReason() => $_has(2);
  @$pb.TagNumber(4)
  void clearReason() => clearField(4);

  /// 返回头
  @$pb.TagNumber(5)
  $core.Map<$core.String, $core.String> get headers => $_getMap(3);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
