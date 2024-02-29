// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'override.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OverrideRequestImpl _$$OverrideRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$OverrideRequestImpl(
      id: json['id'] as String?,
      remark: json['remark'] as String? ?? '',
      isEnabled: json['isEnabled'] as bool? ?? true,
      matcher: OverrideRequestMatcher.fromJson(
          json['matcher'] as Map<String, dynamic>),
      action: OverrideRequestAction.fromJson(
          json['action'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$OverrideRequestImplToJson(
        _$OverrideRequestImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'remark': instance.remark,
      'isEnabled': instance.isEnabled,
      'matcher': instance.matcher,
      'action': instance.action,
    };

_$OverrideRequestMatcherImpl _$$OverrideRequestMatcherImplFromJson(
        Map<String, dynamic> json) =>
    _$OverrideRequestMatcherImpl(
      path: json['path'] as String,
      method: json['method'] as String?,
    );

Map<String, dynamic> _$$OverrideRequestMatcherImplToJson(
        _$OverrideRequestMatcherImpl instance) =>
    <String, dynamic>{
      'path': instance.path,
      'method': instance.method,
    };

_$OverrideRequestActionReplaceImpl _$$OverrideRequestActionReplaceImplFromJson(
        Map<String, dynamic> json) =>
    _$OverrideRequestActionReplaceImpl(
      responseCode: json['responseCode'] as int?,
      responseBody: json['responseBody'] as String?,
    );

Map<String, dynamic> _$$OverrideRequestActionReplaceImplToJson(
        _$OverrideRequestActionReplaceImpl instance) =>
    <String, dynamic>{
      'responseCode': instance.responseCode,
      'responseBody': instance.responseBody,
    };
