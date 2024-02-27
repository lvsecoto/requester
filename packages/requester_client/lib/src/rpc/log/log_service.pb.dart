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

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../common/common.pb.dart' as $1;

/// 日志基本信息
class Log extends $pb.GeneratedMessage {
  factory Log({
    $core.String? id,
    $core.String? clientUid,
    $fixnum.Int64? time,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (clientUid != null) {
      $result.clientUid = clientUid;
    }
    if (time != null) {
      $result.time = time;
    }
    return $result;
  }
  Log._() : super();
  factory Log.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Log.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Log', package: const $pb.PackageName(_omitMessageNames ? '' : 'requester_client'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'clientUid')
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'time', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Log clone() => Log()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Log copyWith(void Function(Log) updates) => super.copyWith((message) => updates(message as Log)) as Log;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Log create() => Log._();
  Log createEmptyInstance() => create();
  static $pb.PbList<Log> createRepeated() => $pb.PbList<Log>();
  @$core.pragma('dart2js:noInline')
  static Log getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Log>(create);
  static Log? _defaultInstance;

  /// id，LogRequest可用来和LogResponse对应
  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  /// 设备的id，表示是哪个设备发出的日志
  @$pb.TagNumber(2)
  $core.String get clientUid => $_getSZ(1);
  @$pb.TagNumber(2)
  set clientUid($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasClientUid() => $_has(1);
  @$pb.TagNumber(2)
  void clearClientUid() => clearField(2);

  /// 日志发送时间
  @$pb.TagNumber(3)
  $fixnum.Int64 get time => $_getI64(2);
  @$pb.TagNumber(3)
  set time($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTime() => $_has(2);
  @$pb.TagNumber(3)
  void clearTime() => clearField(3);
}

/// 请求日志
class LogRequest extends $pb.GeneratedMessage {
  factory LogRequest({
    Log? log,
    $core.String? method,
    $core.String? path,
    $core.Map<$core.String, $core.String>? headers,
    $core.Map<$core.String, $core.String>? queries,
    $core.String? body,
    $1.RpcJson? requestOverridden,
  }) {
    final $result = create();
    if (log != null) {
      $result.log = log;
    }
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
    if (requestOverridden != null) {
      $result.requestOverridden = requestOverridden;
    }
    return $result;
  }
  LogRequest._() : super();
  factory LogRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LogRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LogRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'requester_client'), createEmptyInstance: create)
    ..aOM<Log>(1, _omitFieldNames ? '' : 'log', subBuilder: Log.create)
    ..aOS(2, _omitFieldNames ? '' : 'method')
    ..aOS(3, _omitFieldNames ? '' : 'path')
    ..m<$core.String, $core.String>(4, _omitFieldNames ? '' : 'headers', entryClassName: 'LogRequest.HeadersEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('requester_client'))
    ..m<$core.String, $core.String>(5, _omitFieldNames ? '' : 'queries', entryClassName: 'LogRequest.QueriesEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('requester_client'))
    ..aOS(6, _omitFieldNames ? '' : 'body')
    ..aOM<$1.RpcJson>(7, _omitFieldNames ? '' : 'requestOverridden', subBuilder: $1.RpcJson.create)
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

  /// 基本的日志信息
  @$pb.TagNumber(1)
  Log get log => $_getN(0);
  @$pb.TagNumber(1)
  set log(Log v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasLog() => $_has(0);
  @$pb.TagNumber(1)
  void clearLog() => clearField(1);
  @$pb.TagNumber(1)
  Log ensureLog() => $_ensure(0);

  /// 方法
  @$pb.TagNumber(2)
  $core.String get method => $_getSZ(1);
  @$pb.TagNumber(2)
  set method($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMethod() => $_has(1);
  @$pb.TagNumber(2)
  void clearMethod() => clearField(2);

  /// 路径
  @$pb.TagNumber(3)
  $core.String get path => $_getSZ(2);
  @$pb.TagNumber(3)
  set path($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPath() => $_has(2);
  @$pb.TagNumber(3)
  void clearPath() => clearField(3);

  /// 请求头
  @$pb.TagNumber(4)
  $core.Map<$core.String, $core.String> get headers => $_getMap(3);

  /// queries
  @$pb.TagNumber(5)
  $core.Map<$core.String, $core.String> get queries => $_getMap(4);

  /// 请求体
  @$pb.TagNumber(6)
  $core.String get body => $_getSZ(5);
  @$pb.TagNumber(6)
  set body($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasBody() => $_has(5);
  @$pb.TagNumber(6)
  void clearBody() => clearField(6);

  /// (有)请求重载
  @$pb.TagNumber(7)
  $1.RpcJson get requestOverridden => $_getN(6);
  @$pb.TagNumber(7)
  set requestOverridden($1.RpcJson v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasRequestOverridden() => $_has(6);
  @$pb.TagNumber(7)
  void clearRequestOverridden() => clearField(7);
  @$pb.TagNumber(7)
  $1.RpcJson ensureRequestOverridden() => $_ensure(6);
}

/// 响应日志
class LogResponse extends $pb.GeneratedMessage {
  factory LogResponse({
    Log? log,
    $core.int? spentTime,
    $core.int? code,
    $core.String? body,
    $core.String? error,
    $core.Map<$core.String, $core.String>? headers,
    $1.RpcJson? requestOverridden,
  }) {
    final $result = create();
    if (log != null) {
      $result.log = log;
    }
    if (spentTime != null) {
      $result.spentTime = spentTime;
    }
    if (code != null) {
      $result.code = code;
    }
    if (body != null) {
      $result.body = body;
    }
    if (error != null) {
      $result.error = error;
    }
    if (headers != null) {
      $result.headers.addAll(headers);
    }
    if (requestOverridden != null) {
      $result.requestOverridden = requestOverridden;
    }
    return $result;
  }
  LogResponse._() : super();
  factory LogResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LogResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LogResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'requester_client'), createEmptyInstance: create)
    ..aOM<Log>(1, _omitFieldNames ? '' : 'log', subBuilder: Log.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'spentTime', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'code', $pb.PbFieldType.O3)
    ..aOS(4, _omitFieldNames ? '' : 'body')
    ..aOS(5, _omitFieldNames ? '' : 'error')
    ..m<$core.String, $core.String>(6, _omitFieldNames ? '' : 'headers', entryClassName: 'LogResponse.HeadersEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('requester_client'))
    ..aOM<$1.RpcJson>(7, _omitFieldNames ? '' : 'requestOverridden', subBuilder: $1.RpcJson.create)
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

  /// 基本的日志信息
  @$pb.TagNumber(1)
  Log get log => $_getN(0);
  @$pb.TagNumber(1)
  set log(Log v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasLog() => $_has(0);
  @$pb.TagNumber(1)
  void clearLog() => clearField(1);
  @$pb.TagNumber(1)
  Log ensureLog() => $_ensure(0);

  /// 返回耗费时间
  @$pb.TagNumber(2)
  $core.int get spentTime => $_getIZ(1);
  @$pb.TagNumber(2)
  set spentTime($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSpentTime() => $_has(1);
  @$pb.TagNumber(2)
  void clearSpentTime() => clearField(2);

  /// 返回代码，一般是200
  /// 如果是-1，那么代表错误不是服务器返回的，而是客户端内部原因，比如：网络失去连接
  @$pb.TagNumber(3)
  $core.int get code => $_getIZ(2);
  @$pb.TagNumber(3)
  set code($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearCode() => clearField(3);

  /// 请求体
  @$pb.TagNumber(4)
  $core.String get body => $_getSZ(3);
  @$pb.TagNumber(4)
  set body($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasBody() => $_has(3);
  @$pb.TagNumber(4)
  void clearBody() => clearField(4);

  /// 错误信息
  @$pb.TagNumber(5)
  $core.String get error => $_getSZ(4);
  @$pb.TagNumber(5)
  set error($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasError() => $_has(4);
  @$pb.TagNumber(5)
  void clearError() => clearField(5);

  /// 返回头
  @$pb.TagNumber(6)
  $core.Map<$core.String, $core.String> get headers => $_getMap(5);

  /// (有)请求重载
  @$pb.TagNumber(7)
  $1.RpcJson get requestOverridden => $_getN(6);
  @$pb.TagNumber(7)
  set requestOverridden($1.RpcJson v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasRequestOverridden() => $_has(6);
  @$pb.TagNumber(7)
  void clearRequestOverridden() => clearField(7);
  @$pb.TagNumber(7)
  $1.RpcJson ensureRequestOverridden() => $_ensure(6);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
