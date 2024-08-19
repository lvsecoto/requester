//
//  Generated code. Do not modify.
//  source: client/client_service.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use clientInfoTypeDescriptor instead')
const ClientInfoType$json = {
  '1': 'ClientInfoType',
  '2': [
    {'1': 'text', '2': 0},
    {'1': 'counter', '2': 1},
    {'1': 'number', '2': 2},
    {'1': 'switcher', '2': 3},
    {'1': 'action', '2': 4},
  ],
};

/// Descriptor for `ClientInfoType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List clientInfoTypeDescriptor = $convert.base64Decode(
    'Cg5DbGllbnRJbmZvVHlwZRIICgR0ZXh0EAASCwoHY291bnRlchABEgoKBm51bWJlchACEgwKCH'
    'N3aXRjaGVyEAMSCgoGYWN0aW9uEAQ=');

@$core.Deprecated('Use appStateDescriptor instead')
const AppState$json = {
  '1': 'AppState',
  '2': [
    {'1': 'APP_STATE_RESUMED', '2': 0},
    {'1': 'APP_STATE_INACTIVE', '2': 1},
    {'1': 'APP_STATE_HIDDE', '2': 2},
  ],
};

/// Descriptor for `AppState`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List appStateDescriptor = $convert.base64Decode(
    'CghBcHBTdGF0ZRIVChFBUFBfU1RBVEVfUkVTVU1FRBAAEhYKEkFQUF9TVEFURV9JTkFDVElWRR'
    'ABEhMKD0FQUF9TVEFURV9ISURERRAC');

@$core.Deprecated('Use clientIdDescriptor instead')
const ClientId$json = {
  '1': 'ClientId',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `ClientId`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List clientIdDescriptor = $convert.base64Decode(
    'CghDbGllbnRJZBIOCgJpZBgBIAEoCVICaWQ=');

@$core.Deprecated('Use clientInfoDescriptor instead')
const ClientInfo$json = {
  '1': 'ClientInfo',
  '2': [
    {'1': 'meta', '3': 2, '4': 3, '5': 11, '6': '.client_service.ClientInfo.MetaEntry', '10': 'meta'},
  ],
  '3': [ClientInfo_MetaEntry$json],
};

@$core.Deprecated('Use clientInfoDescriptor instead')
const ClientInfo_MetaEntry$json = {
  '1': 'MetaEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.client_service.ClientMetaValue', '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `ClientInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List clientInfoDescriptor = $convert.base64Decode(
    'CgpDbGllbnRJbmZvEjgKBG1ldGEYAiADKAsyJC5jbGllbnRfc2VydmljZS5DbGllbnRJbmZvLk'
    '1ldGFFbnRyeVIEbWV0YRpYCglNZXRhRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSNQoFdmFsdWUY'
    'AiABKAsyHy5jbGllbnRfc2VydmljZS5DbGllbnRNZXRhVmFsdWVSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use clientInfoEntryDescriptor instead')
const ClientInfoEntry$json = {
  '1': 'ClientInfoEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.client_service.ClientMetaValue', '10': 'value'},
  ],
};

/// Descriptor for `ClientInfoEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List clientInfoEntryDescriptor = $convert.base64Decode(
    'Cg9DbGllbnRJbmZvRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSNQoFdmFsdWUYAiABKAsyHy5jbG'
    'llbnRfc2VydmljZS5DbGllbnRNZXRhVmFsdWVSBXZhbHVl');

@$core.Deprecated('Use clientMetaValueDescriptor instead')
const ClientMetaValue$json = {
  '1': 'ClientMetaValue',
  '2': [
    {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.client_service.ClientInfoType', '10': 'type'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
};

/// Descriptor for `ClientMetaValue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List clientMetaValueDescriptor = $convert.base64Decode(
    'Cg9DbGllbnRNZXRhVmFsdWUSMgoEdHlwZRgBIAEoDjIeLmNsaWVudF9zZXJ2aWNlLkNsaWVudE'
    'luZm9UeXBlUgR0eXBlEhQKBXZhbHVlGAIgASgJUgV2YWx1ZQ==');

@$core.Deprecated('Use logHostPortDescriptor instead')
const LogHostPort$json = {
  '1': 'LogHostPort',
  '2': [
    {'1': 'host', '3': 1, '4': 1, '5': 9, '10': 'host'},
    {'1': 'port', '3': 2, '4': 1, '5': 5, '10': 'port'},
  ],
};

/// Descriptor for `LogHostPort`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List logHostPortDescriptor = $convert.base64Decode(
    'CgtMb2dIb3N0UG9ydBISCgRob3N0GAEgASgJUgRob3N0EhIKBHBvcnQYAiABKAVSBHBvcnQ=');

@$core.Deprecated('Use displayPerformanceDescriptor instead')
const DisplayPerformance$json = {
  '1': 'DisplayPerformance',
  '2': [
    {'1': 'fps', '3': 1, '4': 1, '5': 1, '10': 'fps'},
  ],
};

/// Descriptor for `DisplayPerformance`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List displayPerformanceDescriptor = $convert.base64Decode(
    'ChJEaXNwbGF5UGVyZm9ybWFuY2USEAoDZnBzGAEgASgBUgNmcHM=');

@$core.Deprecated('Use clientAppStateDescriptor instead')
const ClientAppState$json = {
  '1': 'ClientAppState',
  '2': [
    {'1': 'app_state', '3': 1, '4': 1, '5': 14, '6': '.client_service.AppState', '10': 'appState'},
  ],
};

/// Descriptor for `ClientAppState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List clientAppStateDescriptor = $convert.base64Decode(
    'Cg5DbGllbnRBcHBTdGF0ZRI1CglhcHBfc3RhdGUYASABKA4yGC5jbGllbnRfc2VydmljZS5BcH'
    'BTdGF0ZVIIYXBwU3RhdGU=');

@$core.Deprecated('Use screenshotDescriptor instead')
const Screenshot$json = {
  '1': 'Screenshot',
  '2': [
    {'1': 'picture', '3': 1, '4': 1, '5': 12, '10': 'picture'},
  ],
};

/// Descriptor for `Screenshot`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List screenshotDescriptor = $convert.base64Decode(
    'CgpTY3JlZW5zaG90EhgKB3BpY3R1cmUYASABKAxSB3BpY3R1cmU=');

@$core.Deprecated('Use installBundleDescriptor instead')
const InstallBundle$json = {
  '1': 'InstallBundle',
  '2': [
    {'1': 'data', '3': 1, '4': 1, '5': 12, '10': 'data'},
  ],
};

/// Descriptor for `InstallBundle`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List installBundleDescriptor = $convert.base64Decode(
    'Cg1JbnN0YWxsQnVuZGxlEhIKBGRhdGEYASABKAxSBGRhdGE=');

@$core.Deprecated('Use designSketchDescriptor instead')
const DesignSketch$json = {
  '1': 'DesignSketch',
  '2': [
    {'1': 'data', '3': 1, '4': 1, '5': 12, '10': 'data'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `DesignSketch`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List designSketchDescriptor = $convert.base64Decode(
    'CgxEZXNpZ25Ta2V0Y2gSEgoEZGF0YRgBIAEoDFIEZGF0YRISCgRuYW1lGAIgASgJUgRuYW1l');

