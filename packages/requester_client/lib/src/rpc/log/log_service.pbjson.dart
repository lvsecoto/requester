//
//  Generated code. Do not modify.
//  source: log/log_service.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use logRequestDescriptor instead')
const LogRequest$json = {
  '1': 'LogRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'method', '3': 2, '4': 1, '5': 9, '10': 'method'},
    {'1': 'path', '3': 3, '4': 1, '5': 9, '10': 'path'},
    {'1': 'headers', '3': 4, '4': 3, '5': 11, '6': '.requester_client.LogRequest.HeadersEntry', '10': 'headers'},
    {'1': 'queries', '3': 5, '4': 3, '5': 11, '6': '.requester_client.LogRequest.QueriesEntry', '10': 'queries'},
    {'1': 'body', '3': 6, '4': 1, '5': 9, '10': 'body'},
  ],
  '3': [LogRequest_HeadersEntry$json, LogRequest_QueriesEntry$json],
};

@$core.Deprecated('Use logRequestDescriptor instead')
const LogRequest_HeadersEntry$json = {
  '1': 'HeadersEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use logRequestDescriptor instead')
const LogRequest_QueriesEntry$json = {
  '1': 'QueriesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `LogRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List logRequestDescriptor = $convert.base64Decode(
    'CgpMb2dSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZBIWCgZtZXRob2QYAiABKAlSBm1ldGhvZBISCg'
    'RwYXRoGAMgASgJUgRwYXRoEkMKB2hlYWRlcnMYBCADKAsyKS5yZXF1ZXN0ZXJfY2xpZW50Lkxv'
    'Z1JlcXVlc3QuSGVhZGVyc0VudHJ5UgdoZWFkZXJzEkMKB3F1ZXJpZXMYBSADKAsyKS5yZXF1ZX'
    'N0ZXJfY2xpZW50LkxvZ1JlcXVlc3QuUXVlcmllc0VudHJ5UgdxdWVyaWVzEhIKBGJvZHkYBiAB'
    'KAlSBGJvZHkaOgoMSGVhZGVyc0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgAS'
    'gJUgV2YWx1ZToCOAEaOgoMUXVlcmllc0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVl'
    'GAIgASgJUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use logResponseDescriptor instead')
const LogResponse$json = {
  '1': 'LogResponse',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'code', '3': 2, '4': 1, '5': 5, '10': 'code'},
    {'1': 'body', '3': 3, '4': 1, '5': 9, '10': 'body'},
    {'1': 'error', '3': 4, '4': 1, '5': 9, '10': 'error'},
    {'1': 'headers', '3': 5, '4': 3, '5': 11, '6': '.requester_client.LogResponse.HeadersEntry', '10': 'headers'},
  ],
  '3': [LogResponse_HeadersEntry$json],
};

@$core.Deprecated('Use logResponseDescriptor instead')
const LogResponse_HeadersEntry$json = {
  '1': 'HeadersEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `LogResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List logResponseDescriptor = $convert.base64Decode(
    'CgtMb2dSZXNwb25zZRIOCgJpZBgBIAEoCVICaWQSEgoEY29kZRgCIAEoBVIEY29kZRISCgRib2'
    'R5GAMgASgJUgRib2R5EhQKBWVycm9yGAQgASgJUgVlcnJvchJECgdoZWFkZXJzGAUgAygLMiou'
    'cmVxdWVzdGVyX2NsaWVudC5Mb2dSZXNwb25zZS5IZWFkZXJzRW50cnlSB2hlYWRlcnMaOgoMSG'
    'VhZGVyc0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');

