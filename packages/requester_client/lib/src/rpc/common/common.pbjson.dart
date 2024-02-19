//
//  Generated code. Do not modify.
//  source: common/common.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use rpcJsonNullValueDescriptor instead')
const RpcJsonNullValue$json = {
  '1': 'RpcJsonNullValue',
  '2': [
    {'1': 'NULL_VALUE', '2': 0},
  ],
};

/// Descriptor for `RpcJsonNullValue`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List rpcJsonNullValueDescriptor = $convert.base64Decode(
    'ChBScGNKc29uTnVsbFZhbHVlEg4KCk5VTExfVkFMVUUQAA==');

@$core.Deprecated('Use emptyDescriptor instead')
const Empty$json = {
  '1': 'Empty',
};

/// Descriptor for `Empty`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emptyDescriptor = $convert.base64Decode(
    'CgVFbXB0eQ==');

@$core.Deprecated('Use rpcJsonDescriptor instead')
const RpcJson$json = {
  '1': 'RpcJson',
  '2': [
    {'1': 'fields', '3': 1, '4': 3, '5': 11, '6': '.common.RpcJson.FieldsEntry', '10': 'fields'},
  ],
  '3': [RpcJson_FieldsEntry$json],
};

@$core.Deprecated('Use rpcJsonDescriptor instead')
const RpcJson_FieldsEntry$json = {
  '1': 'FieldsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.common.RpcJsonValue', '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `RpcJson`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rpcJsonDescriptor = $convert.base64Decode(
    'CgdScGNKc29uEjMKBmZpZWxkcxgBIAMoCzIbLmNvbW1vbi5ScGNKc29uLkZpZWxkc0VudHJ5Ug'
    'ZmaWVsZHMaTwoLRmllbGRzRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSKgoFdmFsdWUYAiABKAsy'
    'FC5jb21tb24uUnBjSnNvblZhbHVlUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use rpcJsonValueDescriptor instead')
const RpcJsonValue$json = {
  '1': 'RpcJsonValue',
  '2': [
    {'1': 'null_value', '3': 1, '4': 1, '5': 14, '6': '.common.RpcJsonNullValue', '9': 0, '10': 'nullValue'},
    {'1': 'number_value', '3': 2, '4': 1, '5': 1, '9': 0, '10': 'numberValue'},
    {'1': 'integer_value', '3': 3, '4': 1, '5': 4, '9': 0, '10': 'integerValue'},
    {'1': 'string_value', '3': 4, '4': 1, '5': 9, '9': 0, '10': 'stringValue'},
    {'1': 'bool_value', '3': 5, '4': 1, '5': 8, '9': 0, '10': 'boolValue'},
    {'1': 'json_value', '3': 6, '4': 1, '5': 11, '6': '.common.RpcJson', '9': 0, '10': 'jsonValue'},
    {'1': 'list_value', '3': 7, '4': 1, '5': 11, '6': '.common.RpcJsonListValue', '9': 0, '10': 'listValue'},
  ],
  '8': [
    {'1': 'kind'},
  ],
};

/// Descriptor for `RpcJsonValue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rpcJsonValueDescriptor = $convert.base64Decode(
    'CgxScGNKc29uVmFsdWUSOQoKbnVsbF92YWx1ZRgBIAEoDjIYLmNvbW1vbi5ScGNKc29uTnVsbF'
    'ZhbHVlSABSCW51bGxWYWx1ZRIjCgxudW1iZXJfdmFsdWUYAiABKAFIAFILbnVtYmVyVmFsdWUS'
    'JQoNaW50ZWdlcl92YWx1ZRgDIAEoBEgAUgxpbnRlZ2VyVmFsdWUSIwoMc3RyaW5nX3ZhbHVlGA'
    'QgASgJSABSC3N0cmluZ1ZhbHVlEh8KCmJvb2xfdmFsdWUYBSABKAhIAFIJYm9vbFZhbHVlEjAK'
    'Cmpzb25fdmFsdWUYBiABKAsyDy5jb21tb24uUnBjSnNvbkgAUglqc29uVmFsdWUSOQoKbGlzdF'
    '92YWx1ZRgHIAEoCzIYLmNvbW1vbi5ScGNKc29uTGlzdFZhbHVlSABSCWxpc3RWYWx1ZUIGCgRr'
    'aW5k');

@$core.Deprecated('Use rpcJsonListValueDescriptor instead')
const RpcJsonListValue$json = {
  '1': 'RpcJsonListValue',
  '2': [
    {'1': 'values', '3': 1, '4': 3, '5': 11, '6': '.common.RpcJsonValue', '10': 'values'},
  ],
};

/// Descriptor for `RpcJsonListValue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rpcJsonListValueDescriptor = $convert.base64Decode(
    'ChBScGNKc29uTGlzdFZhbHVlEiwKBnZhbHVlcxgBIAMoCzIULmNvbW1vbi5ScGNKc29uVmFsdW'
    'VSBnZhbHVlcw==');

