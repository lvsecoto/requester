//
//  Generated code. Do not modify.
//  source: common/common.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'common.pbenum.dart';

export 'common.pbenum.dart';

class Empty extends $pb.GeneratedMessage {
  factory Empty() => create();
  Empty._() : super();
  factory Empty.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Empty.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Empty', package: const $pb.PackageName(_omitMessageNames ? '' : 'common'), createEmptyInstance: create)
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

/// RPC json
class RpcJson extends $pb.GeneratedMessage {
  factory RpcJson({
    $core.Map<$core.String, RpcJsonValue>? fields,
  }) {
    final $result = create();
    if (fields != null) {
      $result.fields.addAll(fields);
    }
    return $result;
  }
  RpcJson._() : super();
  factory RpcJson.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RpcJson.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RpcJson', package: const $pb.PackageName(_omitMessageNames ? '' : 'common'), createEmptyInstance: create)
    ..m<$core.String, RpcJsonValue>(1, _omitFieldNames ? '' : 'fields', entryClassName: 'RpcJson.FieldsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OM, valueCreator: RpcJsonValue.create, valueDefaultOrMaker: RpcJsonValue.getDefault, packageName: const $pb.PackageName('common'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RpcJson clone() => RpcJson()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RpcJson copyWith(void Function(RpcJson) updates) => super.copyWith((message) => updates(message as RpcJson)) as RpcJson;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RpcJson create() => RpcJson._();
  RpcJson createEmptyInstance() => create();
  static $pb.PbList<RpcJson> createRepeated() => $pb.PbList<RpcJson>();
  @$core.pragma('dart2js:noInline')
  static RpcJson getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RpcJson>(create);
  static RpcJson? _defaultInstance;

  @$pb.TagNumber(1)
  $core.Map<$core.String, RpcJsonValue> get fields => $_getMap(0);
}

enum RpcJsonValue_Kind {
  nullValue, 
  numberValue, 
  integerValue, 
  stringValue, 
  boolValue, 
  jsonValue, 
  listValue, 
  notSet
}

class RpcJsonValue extends $pb.GeneratedMessage {
  factory RpcJsonValue({
    RpcJsonNullValue? nullValue,
    $core.double? numberValue,
    $fixnum.Int64? integerValue,
    $core.String? stringValue,
    $core.bool? boolValue,
    RpcJson? jsonValue,
    RpcJsonListValue? listValue,
  }) {
    final $result = create();
    if (nullValue != null) {
      $result.nullValue = nullValue;
    }
    if (numberValue != null) {
      $result.numberValue = numberValue;
    }
    if (integerValue != null) {
      $result.integerValue = integerValue;
    }
    if (stringValue != null) {
      $result.stringValue = stringValue;
    }
    if (boolValue != null) {
      $result.boolValue = boolValue;
    }
    if (jsonValue != null) {
      $result.jsonValue = jsonValue;
    }
    if (listValue != null) {
      $result.listValue = listValue;
    }
    return $result;
  }
  RpcJsonValue._() : super();
  factory RpcJsonValue.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RpcJsonValue.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, RpcJsonValue_Kind> _RpcJsonValue_KindByTag = {
    1 : RpcJsonValue_Kind.nullValue,
    2 : RpcJsonValue_Kind.numberValue,
    3 : RpcJsonValue_Kind.integerValue,
    4 : RpcJsonValue_Kind.stringValue,
    5 : RpcJsonValue_Kind.boolValue,
    6 : RpcJsonValue_Kind.jsonValue,
    7 : RpcJsonValue_Kind.listValue,
    0 : RpcJsonValue_Kind.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RpcJsonValue', package: const $pb.PackageName(_omitMessageNames ? '' : 'common'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4, 5, 6, 7])
    ..e<RpcJsonNullValue>(1, _omitFieldNames ? '' : 'nullValue', $pb.PbFieldType.OE, defaultOrMaker: RpcJsonNullValue.NULL_VALUE, valueOf: RpcJsonNullValue.valueOf, enumValues: RpcJsonNullValue.values)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'numberValue', $pb.PbFieldType.OD)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'integerValue', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(4, _omitFieldNames ? '' : 'stringValue')
    ..aOB(5, _omitFieldNames ? '' : 'boolValue')
    ..aOM<RpcJson>(6, _omitFieldNames ? '' : 'jsonValue', subBuilder: RpcJson.create)
    ..aOM<RpcJsonListValue>(7, _omitFieldNames ? '' : 'listValue', subBuilder: RpcJsonListValue.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RpcJsonValue clone() => RpcJsonValue()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RpcJsonValue copyWith(void Function(RpcJsonValue) updates) => super.copyWith((message) => updates(message as RpcJsonValue)) as RpcJsonValue;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RpcJsonValue create() => RpcJsonValue._();
  RpcJsonValue createEmptyInstance() => create();
  static $pb.PbList<RpcJsonValue> createRepeated() => $pb.PbList<RpcJsonValue>();
  @$core.pragma('dart2js:noInline')
  static RpcJsonValue getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RpcJsonValue>(create);
  static RpcJsonValue? _defaultInstance;

  RpcJsonValue_Kind whichKind() => _RpcJsonValue_KindByTag[$_whichOneof(0)]!;
  void clearKind() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  RpcJsonNullValue get nullValue => $_getN(0);
  @$pb.TagNumber(1)
  set nullValue(RpcJsonNullValue v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasNullValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearNullValue() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get numberValue => $_getN(1);
  @$pb.TagNumber(2)
  set numberValue($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNumberValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearNumberValue() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get integerValue => $_getI64(2);
  @$pb.TagNumber(3)
  set integerValue($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIntegerValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearIntegerValue() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get stringValue => $_getSZ(3);
  @$pb.TagNumber(4)
  set stringValue($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasStringValue() => $_has(3);
  @$pb.TagNumber(4)
  void clearStringValue() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get boolValue => $_getBF(4);
  @$pb.TagNumber(5)
  set boolValue($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasBoolValue() => $_has(4);
  @$pb.TagNumber(5)
  void clearBoolValue() => clearField(5);

  @$pb.TagNumber(6)
  RpcJson get jsonValue => $_getN(5);
  @$pb.TagNumber(6)
  set jsonValue(RpcJson v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasJsonValue() => $_has(5);
  @$pb.TagNumber(6)
  void clearJsonValue() => clearField(6);
  @$pb.TagNumber(6)
  RpcJson ensureJsonValue() => $_ensure(5);

  @$pb.TagNumber(7)
  RpcJsonListValue get listValue => $_getN(6);
  @$pb.TagNumber(7)
  set listValue(RpcJsonListValue v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasListValue() => $_has(6);
  @$pb.TagNumber(7)
  void clearListValue() => clearField(7);
  @$pb.TagNumber(7)
  RpcJsonListValue ensureListValue() => $_ensure(6);
}

class RpcJsonListValue extends $pb.GeneratedMessage {
  factory RpcJsonListValue({
    $core.Iterable<RpcJsonValue>? values,
  }) {
    final $result = create();
    if (values != null) {
      $result.values.addAll(values);
    }
    return $result;
  }
  RpcJsonListValue._() : super();
  factory RpcJsonListValue.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RpcJsonListValue.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RpcJsonListValue', package: const $pb.PackageName(_omitMessageNames ? '' : 'common'), createEmptyInstance: create)
    ..pc<RpcJsonValue>(1, _omitFieldNames ? '' : 'values', $pb.PbFieldType.PM, subBuilder: RpcJsonValue.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RpcJsonListValue clone() => RpcJsonListValue()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RpcJsonListValue copyWith(void Function(RpcJsonListValue) updates) => super.copyWith((message) => updates(message as RpcJsonListValue)) as RpcJsonListValue;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RpcJsonListValue create() => RpcJsonListValue._();
  RpcJsonListValue createEmptyInstance() => create();
  static $pb.PbList<RpcJsonListValue> createRepeated() => $pb.PbList<RpcJsonListValue>();
  @$core.pragma('dart2js:noInline')
  static RpcJsonListValue getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RpcJsonListValue>(create);
  static RpcJsonListValue? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<RpcJsonValue> get values => $_getList(0);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
