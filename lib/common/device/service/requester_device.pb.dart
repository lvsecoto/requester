//
//  Generated code. Do not modify.
//  source: requester_device.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class Empty extends $pb.GeneratedMessage {
  factory Empty() => create();
  Empty._() : super();
  factory Empty.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Empty.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Empty', package: const $pb.PackageName(_omitMessageNames ? '' : 'requester_device'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Empty clone() => Empty()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Empty copyWith(void Function(Empty) updates) => super.copyWith((message) => updates(message as Empty)) as Empty;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Empty create() => Empty._();
  Empty createEmptyInstance() => create();
  static $pb.PbList<Empty> createRepeated() => $pb.PbList<Empty>();
  @$core.pragma('dart2js:noInline')
  static Empty getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Empty>(create);
  static Empty? _defaultInstance;
}

/// 获取设备信息请求
class RequesterDeviceInfoRequest extends $pb.GeneratedMessage {
  factory RequesterDeviceInfoRequest() => create();
  RequesterDeviceInfoRequest._() : super();
  factory RequesterDeviceInfoRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RequesterDeviceInfoRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RequesterDeviceInfoRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'requester_device'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RequesterDeviceInfoRequest clone() => RequesterDeviceInfoRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RequesterDeviceInfoRequest copyWith(void Function(RequesterDeviceInfoRequest) updates) => super.copyWith((message) => updates(message as RequesterDeviceInfoRequest)) as RequesterDeviceInfoRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RequesterDeviceInfoRequest create() => RequesterDeviceInfoRequest._();
  RequesterDeviceInfoRequest createEmptyInstance() => create();
  static $pb.PbList<RequesterDeviceInfoRequest> createRepeated() => $pb.PbList<RequesterDeviceInfoRequest>();
  @$core.pragma('dart2js:noInline')
  static RequesterDeviceInfoRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RequesterDeviceInfoRequest>(create);
  static RequesterDeviceInfoRequest? _defaultInstance;
}

/// 获取设备信息响应
class RequesterDeviceInfoResponse extends $pb.GeneratedMessage {
  factory RequesterDeviceInfoResponse({
    $core.String? token,
    $core.String? deviceUID,
    $core.Map<$core.String, $core.String>? meta,
  }) {
    final $result = create();
    if (token != null) {
      $result.token = token;
    }
    if (deviceUID != null) {
      $result.deviceUID = deviceUID;
    }
    if (meta != null) {
      $result.meta.addAll(meta);
    }
    return $result;
  }
  RequesterDeviceInfoResponse._() : super();
  factory RequesterDeviceInfoResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RequesterDeviceInfoResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RequesterDeviceInfoResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'requester_device'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..aOS(2, _omitFieldNames ? '' : 'deviceUID', protoName: 'deviceUID')
    ..m<$core.String, $core.String>(3, _omitFieldNames ? '' : 'meta', entryClassName: 'RequesterDeviceInfoResponse.MetaEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('requester_device'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RequesterDeviceInfoResponse clone() => RequesterDeviceInfoResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RequesterDeviceInfoResponse copyWith(void Function(RequesterDeviceInfoResponse) updates) => super.copyWith((message) => updates(message as RequesterDeviceInfoResponse)) as RequesterDeviceInfoResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RequesterDeviceInfoResponse create() => RequesterDeviceInfoResponse._();
  RequesterDeviceInfoResponse createEmptyInstance() => create();
  static $pb.PbList<RequesterDeviceInfoResponse> createRepeated() => $pb.PbList<RequesterDeviceInfoResponse>();
  @$core.pragma('dart2js:noInline')
  static RequesterDeviceInfoResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RequesterDeviceInfoResponse>(create);
  static RequesterDeviceInfoResponse? _defaultInstance;

  /// token
  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => clearField(1);

  /// 设备id
  @$pb.TagNumber(2)
  $core.String get deviceUID => $_getSZ(1);
  @$pb.TagNumber(2)
  set deviceUID($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDeviceUID() => $_has(1);
  @$pb.TagNumber(2)
  void clearDeviceUID() => clearField(2);

  /// 其他信息
  @$pb.TagNumber(3)
  $core.Map<$core.String, $core.String> get meta => $_getMap(2);
}

/// / Requester日志接收端口，设置/获取
class RequesterDeviceLogHostPort extends $pb.GeneratedMessage {
  factory RequesterDeviceLogHostPort({
    $core.String? hostPort,
  }) {
    final $result = create();
    if (hostPort != null) {
      $result.hostPort = hostPort;
    }
    return $result;
  }
  RequesterDeviceLogHostPort._() : super();
  factory RequesterDeviceLogHostPort.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RequesterDeviceLogHostPort.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RequesterDeviceLogHostPort', package: const $pb.PackageName(_omitMessageNames ? '' : 'requester_device'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'hostPort', protoName: 'hostPort')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RequesterDeviceLogHostPort clone() => RequesterDeviceLogHostPort()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RequesterDeviceLogHostPort copyWith(void Function(RequesterDeviceLogHostPort) updates) => super.copyWith((message) => updates(message as RequesterDeviceLogHostPort)) as RequesterDeviceLogHostPort;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RequesterDeviceLogHostPort create() => RequesterDeviceLogHostPort._();
  RequesterDeviceLogHostPort createEmptyInstance() => create();
  static $pb.PbList<RequesterDeviceLogHostPort> createRepeated() => $pb.PbList<RequesterDeviceLogHostPort>();
  @$core.pragma('dart2js:noInline')
  static RequesterDeviceLogHostPort getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RequesterDeviceLogHostPort>(create);
  static RequesterDeviceLogHostPort? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get hostPort => $_getSZ(0);
  @$pb.TagNumber(1)
  set hostPort($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasHostPort() => $_has(0);
  @$pb.TagNumber(1)
  void clearHostPort() => clearField(1);
}

/// / 主机域名重载
class RequesterDeviceApiHostPortOverride extends $pb.GeneratedMessage {
  factory RequesterDeviceApiHostPortOverride({
    $core.String? hostPort,
  }) {
    final $result = create();
    if (hostPort != null) {
      $result.hostPort = hostPort;
    }
    return $result;
  }
  RequesterDeviceApiHostPortOverride._() : super();
  factory RequesterDeviceApiHostPortOverride.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RequesterDeviceApiHostPortOverride.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RequesterDeviceApiHostPortOverride', package: const $pb.PackageName(_omitMessageNames ? '' : 'requester_device'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'hostPort', protoName: 'hostPort')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RequesterDeviceApiHostPortOverride clone() => RequesterDeviceApiHostPortOverride()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RequesterDeviceApiHostPortOverride copyWith(void Function(RequesterDeviceApiHostPortOverride) updates) => super.copyWith((message) => updates(message as RequesterDeviceApiHostPortOverride)) as RequesterDeviceApiHostPortOverride;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RequesterDeviceApiHostPortOverride create() => RequesterDeviceApiHostPortOverride._();
  RequesterDeviceApiHostPortOverride createEmptyInstance() => create();
  static $pb.PbList<RequesterDeviceApiHostPortOverride> createRepeated() => $pb.PbList<RequesterDeviceApiHostPortOverride>();
  @$core.pragma('dart2js:noInline')
  static RequesterDeviceApiHostPortOverride getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RequesterDeviceApiHostPortOverride>(create);
  static RequesterDeviceApiHostPortOverride? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get hostPort => $_getSZ(0);
  @$pb.TagNumber(1)
  set hostPort($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasHostPort() => $_has(0);
  @$pb.TagNumber(1)
  void clearHostPort() => clearField(1);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
