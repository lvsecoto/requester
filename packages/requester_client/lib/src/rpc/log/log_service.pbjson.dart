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
    {'1': 'method', '3': 1, '4': 1, '5': 9, '10': 'method'},
    {'1': 'path', '3': 2, '4': 1, '5': 9, '10': 'path'},
    {'1': 'headers', '3': 3, '4': 3, '5': 11, '6': '.requester_client.LogRequest.HeadersEntry', '10': 'headers'},
    {'1': 'queries', '3': 4, '4': 3, '5': 11, '6': '.requester_client.LogRequest.QueriesEntry', '10': 'queries'},
    {'1': 'body', '3': 5, '4': 1, '5': 9, '10': 'body'},
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
    'CgpMb2dSZXF1ZXN0EhYKBm1ldGhvZBgBIAEoCVIGbWV0aG9kEhIKBHBhdGgYAiABKAlSBHBhdG'
    'gSQwoHaGVhZGVycxgDIAMoCzIpLnJlcXVlc3Rlcl9jbGllbnQuTG9nUmVxdWVzdC5IZWFkZXJz'
    'RW50cnlSB2hlYWRlcnMSQwoHcXVlcmllcxgEIAMoCzIpLnJlcXVlc3Rlcl9jbGllbnQuTG9nUm'
    'VxdWVzdC5RdWVyaWVzRW50cnlSB3F1ZXJpZXMSEgoEYm9keRgFIAEoCVIEYm9keRo6CgxIZWFk'
    'ZXJzRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4ARo6Cg'
    'xRdWVyaWVzRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4'
    'AQ==');

@$core.Deprecated('Use logResponseDescriptor instead')
const LogResponse$json = {
  '1': 'LogResponse',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 13, '10': 'code'},
    {'1': 'body', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'body'},
    {'1': 'reason', '3': 4, '4': 1, '5': 9, '9': 0, '10': 'reason'},
    {'1': 'headers', '3': 5, '4': 3, '5': 11, '6': '.requester_client.LogResponse.HeadersEntry', '10': 'headers'},
  ],
  '3': [LogResponse_HeadersEntry$json],
  '8': [
    {'1': 'content'},
  ],
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
    'CgtMb2dSZXNwb25zZRISCgRjb2RlGAEgASgNUgRjb2RlEhQKBGJvZHkYAyABKAlIAFIEYm9keR'
    'IYCgZyZWFzb24YBCABKAlIAFIGcmVhc29uEkQKB2hlYWRlcnMYBSADKAsyKi5yZXF1ZXN0ZXJf'
    'Y2xpZW50LkxvZ1Jlc3BvbnNlLkhlYWRlcnNFbnRyeVIHaGVhZGVycxo6CgxIZWFkZXJzRW50cn'
    'kSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AUIJCgdjb250ZW50');

