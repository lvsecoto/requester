//
//  Generated code. Do not modify.
//  source: client/client_service.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class AppState extends $pb.ProtobufEnum {
  static const AppState APP_STATE_RESUMED = AppState._(0, _omitEnumNames ? '' : 'APP_STATE_RESUMED');
  static const AppState APP_STATE_INACTIVE = AppState._(1, _omitEnumNames ? '' : 'APP_STATE_INACTIVE');
  static const AppState APP_STATE_HIDDE = AppState._(2, _omitEnumNames ? '' : 'APP_STATE_HIDDE');

  static const $core.List<AppState> values = <AppState> [
    APP_STATE_RESUMED,
    APP_STATE_INACTIVE,
    APP_STATE_HIDDE,
  ];

  static final $core.Map<$core.int, AppState> _byValue = $pb.ProtobufEnum.initByValue(values);
  static AppState? valueOf($core.int value) => _byValue[value];

  const AppState._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
