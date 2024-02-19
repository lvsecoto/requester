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

import 'package:protobuf/protobuf.dart' as $pb;

class RpcJsonNullValue extends $pb.ProtobufEnum {
  static const RpcJsonNullValue NULL_VALUE = RpcJsonNullValue._(0, _omitEnumNames ? '' : 'NULL_VALUE');

  static const $core.List<RpcJsonNullValue> values = <RpcJsonNullValue> [
    NULL_VALUE,
  ];

  static final $core.Map<$core.int, RpcJsonNullValue> _byValue = $pb.ProtobufEnum.initByValue(values);
  static RpcJsonNullValue? valueOf($core.int value) => _byValue[value];

  const RpcJsonNullValue._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
