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
    {'1': 'log', '3': 1, '4': 1, '5': 11, '6': '.log_service.Log', '10': 'log'},
    {'1': 'method', '3': 2, '4': 1, '5': 9, '10': 'method'},
    {'1': 'path', '3': 3, '4': 1, '5': 9, '10': 'path'},
    {'1': 'headers', '3': 4, '4': 3, '5': 11, '6': '.log_service.LogRequest.HeadersEntry', '10': 'headers'},
    {'1': 'queries', '3': 5, '4': 3, '5': 11, '6': '.log_service.LogRequest.QueriesEntry', '10': 'queries'},
    {'1': 'body', '3': 6, '4': 1, '5': 9, '10': 'body'},
    {'1': 'request_overridden', '3': 7, '4': 1, '5': 11, '6': '.common.RpcJson', '10': 'requestOverridden'},
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
    'CgpMb2dSZXF1ZXN0EiIKA2xvZxgBIAEoCzIQLmxvZ19zZXJ2aWNlLkxvZ1IDbG9nEhYKBm1ldG'
    'hvZBgCIAEoCVIGbWV0aG9kEhIKBHBhdGgYAyABKAlSBHBhdGgSPgoHaGVhZGVycxgEIAMoCzIk'
    'LmxvZ19zZXJ2aWNlLkxvZ1JlcXVlc3QuSGVhZGVyc0VudHJ5UgdoZWFkZXJzEj4KB3F1ZXJpZX'
    'MYBSADKAsyJC5sb2dfc2VydmljZS5Mb2dSZXF1ZXN0LlF1ZXJpZXNFbnRyeVIHcXVlcmllcxIS'
    'CgRib2R5GAYgASgJUgRib2R5Ej4KEnJlcXVlc3Rfb3ZlcnJpZGRlbhgHIAEoCzIPLmNvbW1vbi'
    '5ScGNKc29uUhFyZXF1ZXN0T3ZlcnJpZGRlbho6CgxIZWFkZXJzRW50cnkSEAoDa2V5GAEgASgJ'
    'UgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4ARo6CgxRdWVyaWVzRW50cnkSEAoDa2V5GA'
    'EgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use logResponseDescriptor instead')
const LogResponse$json = {
  '1': 'LogResponse',
  '2': [
    {'1': 'log', '3': 1, '4': 1, '5': 11, '6': '.log_service.Log', '10': 'log'},
    {'1': 'spent_time', '3': 2, '4': 1, '5': 13, '10': 'spentTime'},
    {'1': 'code', '3': 3, '4': 1, '5': 5, '10': 'code'},
    {'1': 'body', '3': 4, '4': 1, '5': 9, '10': 'body'},
    {'1': 'error', '3': 5, '4': 1, '5': 9, '10': 'error'},
    {'1': 'headers', '3': 6, '4': 3, '5': 11, '6': '.log_service.LogResponse.HeadersEntry', '10': 'headers'},
    {'1': 'request_overridden', '3': 7, '4': 1, '5': 11, '6': '.common.RpcJson', '10': 'requestOverridden'},
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
    'CgtMb2dSZXNwb25zZRIiCgNsb2cYASABKAsyEC5sb2dfc2VydmljZS5Mb2dSA2xvZxIdCgpzcG'
    'VudF90aW1lGAIgASgNUglzcGVudFRpbWUSEgoEY29kZRgDIAEoBVIEY29kZRISCgRib2R5GAQg'
    'ASgJUgRib2R5EhQKBWVycm9yGAUgASgJUgVlcnJvchI/CgdoZWFkZXJzGAYgAygLMiUubG9nX3'
    'NlcnZpY2UuTG9nUmVzcG9uc2UuSGVhZGVyc0VudHJ5UgdoZWFkZXJzEj4KEnJlcXVlc3Rfb3Zl'
    'cnJpZGRlbhgHIAEoCzIPLmNvbW1vbi5ScGNKc29uUhFyZXF1ZXN0T3ZlcnJpZGRlbho6CgxIZW'
    'FkZXJzRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use logAppStateDescriptor instead')
const LogAppState$json = {
  '1': 'LogAppState',
  '2': [
    {'1': 'log', '3': 1, '4': 1, '5': 11, '6': '.log_service.Log', '10': 'log'},
    {'1': 'app_state', '3': 2, '4': 1, '5': 14, '6': '.client_service.AppState', '10': 'appState'},
  ],
};

/// Descriptor for `LogAppState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List logAppStateDescriptor = $convert.base64Decode(
    'CgtMb2dBcHBTdGF0ZRIiCgNsb2cYASABKAsyEC5sb2dfc2VydmljZS5Mb2dSA2xvZxI1CglhcH'
    'Bfc3RhdGUYAiABKA4yGC5jbGllbnRfc2VydmljZS5BcHBTdGF0ZVIIYXBwU3RhdGU=');

