//
//  Generated code. Do not modify.
//  source: client/client_service.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'client_service.pbenum.dart';

export 'client_service.pbenum.dart';

class ClientId extends $pb.GeneratedMessage {
  factory ClientId({
    $core.String? id,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    return $result;
  }
  ClientId._() : super();
  factory ClientId.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ClientId.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ClientId', package: const $pb.PackageName(_omitMessageNames ? '' : 'client_service'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ClientId clone() => ClientId()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ClientId copyWith(void Function(ClientId) updates) => super.copyWith((message) => updates(message as ClientId)) as ClientId;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ClientId create() => ClientId._();
  ClientId createEmptyInstance() => create();
  static $pb.PbList<ClientId> createRepeated() => $pb.PbList<ClientId>();
  @$core.pragma('dart2js:noInline')
  static ClientId getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ClientId>(create);
  static ClientId? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

/// 获取设备信息响应
class ClientInfo extends $pb.GeneratedMessage {
  factory ClientInfo({
    $core.Map<$core.String, ClientMetaValue>? meta,
  }) {
    final $result = create();
    if (meta != null) {
      $result.meta.addAll(meta);
    }
    return $result;
  }
  ClientInfo._() : super();
  factory ClientInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ClientInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ClientInfo', package: const $pb.PackageName(_omitMessageNames ? '' : 'client_service'), createEmptyInstance: create)
    ..m<$core.String, ClientMetaValue>(2, _omitFieldNames ? '' : 'meta', entryClassName: 'ClientInfo.MetaEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OM, valueCreator: ClientMetaValue.create, valueDefaultOrMaker: ClientMetaValue.getDefault, packageName: const $pb.PackageName('client_service'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ClientInfo clone() => ClientInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ClientInfo copyWith(void Function(ClientInfo) updates) => super.copyWith((message) => updates(message as ClientInfo)) as ClientInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ClientInfo create() => ClientInfo._();
  ClientInfo createEmptyInstance() => create();
  static $pb.PbList<ClientInfo> createRepeated() => $pb.PbList<ClientInfo>();
  @$core.pragma('dart2js:noInline')
  static ClientInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ClientInfo>(create);
  static ClientInfo? _defaultInstance;

  /// 信息，客户端以key-value形式上报
  @$pb.TagNumber(2)
  $core.Map<$core.String, ClientMetaValue> get meta => $_getMap(0);
}

class ClientInfoEntry extends $pb.GeneratedMessage {
  factory ClientInfoEntry({
    $core.String? key,
    ClientMetaValue? value,
  }) {
    final $result = create();
    if (key != null) {
      $result.key = key;
    }
    if (value != null) {
      $result.value = value;
    }
    return $result;
  }
  ClientInfoEntry._() : super();
  factory ClientInfoEntry.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ClientInfoEntry.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ClientInfoEntry', package: const $pb.PackageName(_omitMessageNames ? '' : 'client_service'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'key')
    ..aOM<ClientMetaValue>(2, _omitFieldNames ? '' : 'value', subBuilder: ClientMetaValue.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ClientInfoEntry clone() => ClientInfoEntry()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ClientInfoEntry copyWith(void Function(ClientInfoEntry) updates) => super.copyWith((message) => updates(message as ClientInfoEntry)) as ClientInfoEntry;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ClientInfoEntry create() => ClientInfoEntry._();
  ClientInfoEntry createEmptyInstance() => create();
  static $pb.PbList<ClientInfoEntry> createRepeated() => $pb.PbList<ClientInfoEntry>();
  @$core.pragma('dart2js:noInline')
  static ClientInfoEntry getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ClientInfoEntry>(create);
  static ClientInfoEntry? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get key => $_getSZ(0);
  @$pb.TagNumber(1)
  set key($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);

  @$pb.TagNumber(2)
  ClientMetaValue get value => $_getN(1);
  @$pb.TagNumber(2)
  set value(ClientMetaValue v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => clearField(2);
  @$pb.TagNumber(2)
  ClientMetaValue ensureValue() => $_ensure(1);
}

class ClientMetaValue extends $pb.GeneratedMessage {
  factory ClientMetaValue({
    $core.String? value,
  }) {
    final $result = create();
    if (value != null) {
      $result.value = value;
    }
    return $result;
  }
  ClientMetaValue._() : super();
  factory ClientMetaValue.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ClientMetaValue.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ClientMetaValue', package: const $pb.PackageName(_omitMessageNames ? '' : 'client_service'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'value')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ClientMetaValue clone() => ClientMetaValue()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ClientMetaValue copyWith(void Function(ClientMetaValue) updates) => super.copyWith((message) => updates(message as ClientMetaValue)) as ClientMetaValue;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ClientMetaValue create() => ClientMetaValue._();
  ClientMetaValue createEmptyInstance() => create();
  static $pb.PbList<ClientMetaValue> createRepeated() => $pb.PbList<ClientMetaValue>();
  @$core.pragma('dart2js:noInline')
  static ClientMetaValue getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ClientMetaValue>(create);
  static ClientMetaValue? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get value => $_getSZ(0);
  @$pb.TagNumber(1)
  set value($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);
}

/// / Requester日志接收端口，设置/获取
class LogHostPort extends $pb.GeneratedMessage {
  factory LogHostPort({
    $core.String? host,
    $core.int? port,
  }) {
    final $result = create();
    if (host != null) {
      $result.host = host;
    }
    if (port != null) {
      $result.port = port;
    }
    return $result;
  }
  LogHostPort._() : super();
  factory LogHostPort.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LogHostPort.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LogHostPort', package: const $pb.PackageName(_omitMessageNames ? '' : 'client_service'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'host')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'port', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LogHostPort clone() => LogHostPort()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LogHostPort copyWith(void Function(LogHostPort) updates) => super.copyWith((message) => updates(message as LogHostPort)) as LogHostPort;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LogHostPort create() => LogHostPort._();
  LogHostPort createEmptyInstance() => create();
  static $pb.PbList<LogHostPort> createRepeated() => $pb.PbList<LogHostPort>();
  @$core.pragma('dart2js:noInline')
  static LogHostPort getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LogHostPort>(create);
  static LogHostPort? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get host => $_getSZ(0);
  @$pb.TagNumber(1)
  set host($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasHost() => $_has(0);
  @$pb.TagNumber(1)
  void clearHost() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get port => $_getIZ(1);
  @$pb.TagNumber(2)
  set port($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPort() => $_has(1);
  @$pb.TagNumber(2)
  void clearPort() => clearField(2);
}

class DisplayPerformance extends $pb.GeneratedMessage {
  factory DisplayPerformance({
    $core.double? fps,
  }) {
    final $result = create();
    if (fps != null) {
      $result.fps = fps;
    }
    return $result;
  }
  DisplayPerformance._() : super();
  factory DisplayPerformance.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DisplayPerformance.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DisplayPerformance', package: const $pb.PackageName(_omitMessageNames ? '' : 'client_service'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'fps', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DisplayPerformance clone() => DisplayPerformance()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DisplayPerformance copyWith(void Function(DisplayPerformance) updates) => super.copyWith((message) => updates(message as DisplayPerformance)) as DisplayPerformance;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DisplayPerformance create() => DisplayPerformance._();
  DisplayPerformance createEmptyInstance() => create();
  static $pb.PbList<DisplayPerformance> createRepeated() => $pb.PbList<DisplayPerformance>();
  @$core.pragma('dart2js:noInline')
  static DisplayPerformance getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DisplayPerformance>(create);
  static DisplayPerformance? _defaultInstance;

  /// / 帧率，每秒帧数
  @$pb.TagNumber(1)
  $core.double get fps => $_getN(0);
  @$pb.TagNumber(1)
  set fps($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFps() => $_has(0);
  @$pb.TagNumber(1)
  void clearFps() => clearField(1);
}

class ClientAppState extends $pb.GeneratedMessage {
  factory ClientAppState({
    AppState? appState,
  }) {
    final $result = create();
    if (appState != null) {
      $result.appState = appState;
    }
    return $result;
  }
  ClientAppState._() : super();
  factory ClientAppState.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ClientAppState.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ClientAppState', package: const $pb.PackageName(_omitMessageNames ? '' : 'client_service'), createEmptyInstance: create)
    ..e<AppState>(1, _omitFieldNames ? '' : 'appState', $pb.PbFieldType.OE, defaultOrMaker: AppState.APP_STATE_RESUMED, valueOf: AppState.valueOf, enumValues: AppState.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ClientAppState clone() => ClientAppState()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ClientAppState copyWith(void Function(ClientAppState) updates) => super.copyWith((message) => updates(message as ClientAppState)) as ClientAppState;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ClientAppState create() => ClientAppState._();
  ClientAppState createEmptyInstance() => create();
  static $pb.PbList<ClientAppState> createRepeated() => $pb.PbList<ClientAppState>();
  @$core.pragma('dart2js:noInline')
  static ClientAppState getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ClientAppState>(create);
  static ClientAppState? _defaultInstance;

  @$pb.TagNumber(1)
  AppState get appState => $_getN(0);
  @$pb.TagNumber(1)
  set appState(AppState v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAppState() => $_has(0);
  @$pb.TagNumber(1)
  void clearAppState() => clearField(1);
}

/// / 截屏
class Screenshot extends $pb.GeneratedMessage {
  factory Screenshot({
    $core.List<$core.int>? picture,
  }) {
    final $result = create();
    if (picture != null) {
      $result.picture = picture;
    }
    return $result;
  }
  Screenshot._() : super();
  factory Screenshot.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Screenshot.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Screenshot', package: const $pb.PackageName(_omitMessageNames ? '' : 'client_service'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'picture', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Screenshot clone() => Screenshot()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Screenshot copyWith(void Function(Screenshot) updates) => super.copyWith((message) => updates(message as Screenshot)) as Screenshot;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Screenshot create() => Screenshot._();
  Screenshot createEmptyInstance() => create();
  static $pb.PbList<Screenshot> createRepeated() => $pb.PbList<Screenshot>();
  @$core.pragma('dart2js:noInline')
  static Screenshot getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Screenshot>(create);
  static Screenshot? _defaultInstance;

  /// / 截屏图片数据
  @$pb.TagNumber(1)
  $core.List<$core.int> get picture => $_getN(0);
  @$pb.TagNumber(1)
  set picture($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPicture() => $_has(0);
  @$pb.TagNumber(1)
  void clearPicture() => clearField(1);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
