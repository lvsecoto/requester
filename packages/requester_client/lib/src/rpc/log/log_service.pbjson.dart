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

@$core.Deprecated('Use logDescriptor instead')
const Log$json = {
  '1': 'Log',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'client_uid', '3': 2, '4': 1, '5': 9, '10': 'clientUid'},
    {'1': 'time', '3': 3, '4': 1, '5': 4, '10': 'time'},
  ],
};

/// Descriptor for `Log`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List logDescriptor = $convert.base64Decode(
    'CgNMb2cSDgoCaWQYASABKAlSAmlkEh0KCmNsaWVudF91aWQYAiABKAlSCWNsaWVudFVpZBISCg'
    'R0aW1lGAMgASgEUgR0aW1l');

@$core.Deprecated('Use logRequestDescriptor instead')
const LogRequest$json = {
  '1': 'LogRequest',
  '2': [
    {'1': 'log', '3': 1, '4': 1, '5': 11, '6': '.requester_client.Log', '10': 'log'},
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
    'CgpMb2dSZXF1ZXN0EicKA2xvZxgBIAEoCzIVLnJlcXVlc3Rlcl9jbGllbnQuTG9nUgNsb2cSFg'
    'oGbWV0aG9kGAIgASgJUgZtZXRob2QSEgoEcGF0aBgDIAEoCVIEcGF0aBJDCgdoZWFkZXJzGAQg'
    'AygLMikucmVxdWVzdGVyX2NsaWVudC5Mb2dSZXF1ZXN0LkhlYWRlcnNFbnRyeVIHaGVhZGVycx'
    'JDCgdxdWVyaWVzGAUgAygLMikucmVxdWVzdGVyX2NsaWVudC5Mb2dSZXF1ZXN0LlF1ZXJpZXNF'
    'bnRyeVIHcXVlcmllcxISCgRib2R5GAYgASgJUgRib2R5GjoKDEhlYWRlcnNFbnRyeRIQCgNrZX'
    'kYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgBGjoKDFF1ZXJpZXNFbnRyeRIQ'
    'CgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');

@$core.Deprecated('Use logResponseDescriptor instead')
const LogResponse$json = {
  '1': 'LogResponse',
  '2': [
    {'1': 'log', '3': 1, '4': 1, '5': 11, '6': '.requester_client.Log', '10': 'log'},
    {'1': 'spent_time', '3': 2, '4': 1, '5': 13, '10': 'spentTime'},
    {'1': 'code', '3': 3, '4': 1, '5': 5, '10': 'code'},
    {'1': 'body', '3': 4, '4': 1, '5': 9, '10': 'body'},
    {'1': 'error', '3': 5, '4': 1, '5': 9, '10': 'error'},
    {'1': 'headers', '3': 6, '4': 3, '5': 11, '6': '.requester_client.LogResponse.HeadersEntry', '10': 'headers'},
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
    'CgtMb2dSZXNwb25zZRInCgNsb2cYASABKAsyFS5yZXF1ZXN0ZXJfY2xpZW50LkxvZ1IDbG9nEh'
    '0KCnNwZW50X3RpbWUYAiABKA1SCXNwZW50VGltZRISCgRjb2RlGAMgASgFUgRjb2RlEhIKBGJv'
    'ZHkYBCABKAlSBGJvZHkSFAoFZXJyb3IYBSABKAlSBWVycm9yEkQKB2hlYWRlcnMYBiADKAsyKi'
    '5yZXF1ZXN0ZXJfY2xpZW50LkxvZ1Jlc3BvbnNlLkhlYWRlcnNFbnRyeVIHaGVhZGVycxo6CgxI'
    'ZWFkZXJzRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AQ'
    '==');

