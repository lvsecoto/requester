//
//  Generated code. Do not modify.
//  source: requester_device.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use emptyDescriptor instead')
const Empty$json = {
  '1': 'Empty',
};

/// Descriptor for `Empty`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emptyDescriptor = $convert.base64Decode(
    'CgVFbXB0eQ==');

@$core.Deprecated('Use requesterDeviceInfoRequestDescriptor instead')
const RequesterDeviceInfoRequest$json = {
  '1': 'RequesterDeviceInfoRequest',
};

/// Descriptor for `RequesterDeviceInfoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requesterDeviceInfoRequestDescriptor = $convert.base64Decode(
    'ChpSZXF1ZXN0ZXJEZXZpY2VJbmZvUmVxdWVzdA==');

@$core.Deprecated('Use requesterDeviceInfoResponseDescriptor instead')
const RequesterDeviceInfoResponse$json = {
  '1': 'RequesterDeviceInfoResponse',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    {'1': 'deviceUID', '3': 2, '4': 1, '5': 9, '10': 'deviceUID'},
    {'1': 'meta', '3': 3, '4': 3, '5': 11, '6': '.requester_device.RequesterDeviceInfoResponse.MetaEntry', '10': 'meta'},
  ],
  '3': [RequesterDeviceInfoResponse_MetaEntry$json],
};

@$core.Deprecated('Use requesterDeviceInfoResponseDescriptor instead')
const RequesterDeviceInfoResponse_MetaEntry$json = {
  '1': 'MetaEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `RequesterDeviceInfoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requesterDeviceInfoResponseDescriptor = $convert.base64Decode(
    'ChtSZXF1ZXN0ZXJEZXZpY2VJbmZvUmVzcG9uc2USFAoFdG9rZW4YASABKAlSBXRva2VuEhwKCW'
    'RldmljZVVJRBgCIAEoCVIJZGV2aWNlVUlEEksKBG1ldGEYAyADKAsyNy5yZXF1ZXN0ZXJfZGV2'
    'aWNlLlJlcXVlc3RlckRldmljZUluZm9SZXNwb25zZS5NZXRhRW50cnlSBG1ldGEaNwoJTWV0YU'
    'VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use requesterDeviceLogHostPortDescriptor instead')
const RequesterDeviceLogHostPort$json = {
  '1': 'RequesterDeviceLogHostPort',
  '2': [
    {'1': 'hostPort', '3': 1, '4': 1, '5': 9, '10': 'hostPort'},
  ],
};

/// Descriptor for `RequesterDeviceLogHostPort`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requesterDeviceLogHostPortDescriptor = $convert.base64Decode(
    'ChpSZXF1ZXN0ZXJEZXZpY2VMb2dIb3N0UG9ydBIaCghob3N0UG9ydBgBIAEoCVIIaG9zdFBvcn'
    'Q=');

@$core.Deprecated('Use requesterDeviceApiHostPortOverrideDescriptor instead')
const RequesterDeviceApiHostPortOverride$json = {
  '1': 'RequesterDeviceApiHostPortOverride',
  '2': [
    {'1': 'hostPort', '3': 1, '4': 1, '5': 9, '10': 'hostPort'},
  ],
};

/// Descriptor for `RequesterDeviceApiHostPortOverride`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requesterDeviceApiHostPortOverrideDescriptor = $convert.base64Decode(
    'CiJSZXF1ZXN0ZXJEZXZpY2VBcGlIb3N0UG9ydE92ZXJyaWRlEhoKCGhvc3RQb3J0GAEgASgJUg'
    'hob3N0UG9ydA==');

