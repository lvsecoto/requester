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

/// / 设备信息类型
class ClientInfoType extends $pb.ProtobufEnum {
  static const ClientInfoType text = ClientInfoType._(0, _omitEnumNames ? '' : 'text');
  static const ClientInfoType counter = ClientInfoType._(1, _omitEnumNames ? '' : 'counter');
  static const ClientInfoType number = ClientInfoType._(2, _omitEnumNames ? '' : 'number');
  static const ClientInfoType switcher = ClientInfoType._(3, _omitEnumNames ? '' : 'switcher');
  static const ClientInfoType action = ClientInfoType._(4, _omitEnumNames ? '' : 'action');

  static const $core.List<ClientInfoType> values = <ClientInfoType> [
    text,
    counter,
    number,
    switcher,
    action,
  ];

  static final $core.Map<$core.int, ClientInfoType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ClientInfoType? valueOf($core.int value) => _byValue[value];

  const ClientInfoType._($core.int v, $core.String n) : super(v, n);
}

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
