// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'requester_device.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RequesterClient {
  String get clientUid => throw _privateConstructorUsedError;
  String get appName => throw _privateConstructorUsedError;
  String get appVersion => throw _privateConstructorUsedError;
  String get clientId => throw _privateConstructorUsedError;

  /// 设备的访问地址
  HostPort get hostPort => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RequesterClientCopyWith<RequesterClient> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequesterClientCopyWith<$Res> {
  factory $RequesterClientCopyWith(
          RequesterClient value, $Res Function(RequesterClient) then) =
      _$RequesterClientCopyWithImpl<$Res, RequesterClient>;
  @useResult
  $Res call(
      {String clientUid,
      String appName,
      String appVersion,
      String clientId,
      HostPort hostPort});

  $HostPortCopyWith<$Res> get hostPort;
}

/// @nodoc
class _$RequesterClientCopyWithImpl<$Res, $Val extends RequesterClient>
    implements $RequesterClientCopyWith<$Res> {
  _$RequesterClientCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clientUid = null,
    Object? appName = null,
    Object? appVersion = null,
    Object? clientId = null,
    Object? hostPort = null,
  }) {
    return _then(_value.copyWith(
      clientUid: null == clientUid
          ? _value.clientUid
          : clientUid // ignore: cast_nullable_to_non_nullable
              as String,
      appName: null == appName
          ? _value.appName
          : appName // ignore: cast_nullable_to_non_nullable
              as String,
      appVersion: null == appVersion
          ? _value.appVersion
          : appVersion // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      hostPort: null == hostPort
          ? _value.hostPort
          : hostPort // ignore: cast_nullable_to_non_nullable
              as HostPort,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $HostPortCopyWith<$Res> get hostPort {
    return $HostPortCopyWith<$Res>(_value.hostPort, (value) {
      return _then(_value.copyWith(hostPort: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RequesterClientImplCopyWith<$Res>
    implements $RequesterClientCopyWith<$Res> {
  factory _$$RequesterClientImplCopyWith(_$RequesterClientImpl value,
          $Res Function(_$RequesterClientImpl) then) =
      __$$RequesterClientImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String clientUid,
      String appName,
      String appVersion,
      String clientId,
      HostPort hostPort});

  @override
  $HostPortCopyWith<$Res> get hostPort;
}

/// @nodoc
class __$$RequesterClientImplCopyWithImpl<$Res>
    extends _$RequesterClientCopyWithImpl<$Res, _$RequesterClientImpl>
    implements _$$RequesterClientImplCopyWith<$Res> {
  __$$RequesterClientImplCopyWithImpl(
      _$RequesterClientImpl _value, $Res Function(_$RequesterClientImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clientUid = null,
    Object? appName = null,
    Object? appVersion = null,
    Object? clientId = null,
    Object? hostPort = null,
  }) {
    return _then(_$RequesterClientImpl(
      clientUid: null == clientUid
          ? _value.clientUid
          : clientUid // ignore: cast_nullable_to_non_nullable
              as String,
      appName: null == appName
          ? _value.appName
          : appName // ignore: cast_nullable_to_non_nullable
              as String,
      appVersion: null == appVersion
          ? _value.appVersion
          : appVersion // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      hostPort: null == hostPort
          ? _value.hostPort
          : hostPort // ignore: cast_nullable_to_non_nullable
              as HostPort,
    ));
  }
}

/// @nodoc

class _$RequesterClientImpl extends _RequesterClient {
  const _$RequesterClientImpl(
      {required this.clientUid,
      required this.appName,
      required this.appVersion,
      required this.clientId,
      required this.hostPort})
      : super._();

  @override
  final String clientUid;
  @override
  final String appName;
  @override
  final String appVersion;
  @override
  final String clientId;

  /// 设备的访问地址
  @override
  final HostPort hostPort;

  @override
  String toString() {
    return 'RequesterClient(clientUid: $clientUid, appName: $appName, appVersion: $appVersion, clientId: $clientId, hostPort: $hostPort)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequesterClientImpl &&
            (identical(other.clientUid, clientUid) ||
                other.clientUid == clientUid) &&
            (identical(other.appName, appName) || other.appName == appName) &&
            (identical(other.appVersion, appVersion) ||
                other.appVersion == appVersion) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.hostPort, hostPort) ||
                other.hostPort == hostPort));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, clientUid, appName, appVersion, clientId, hostPort);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RequesterClientImplCopyWith<_$RequesterClientImpl> get copyWith =>
      __$$RequesterClientImplCopyWithImpl<_$RequesterClientImpl>(
          this, _$identity);
}

abstract class _RequesterClient extends RequesterClient {
  const factory _RequesterClient(
      {required final String clientUid,
      required final String appName,
      required final String appVersion,
      required final String clientId,
      required final HostPort hostPort}) = _$RequesterClientImpl;
  const _RequesterClient._() : super._();

  @override
  String get clientUid;
  @override
  String get appName;
  @override
  String get appVersion;
  @override
  String get clientId;
  @override

  /// 设备的访问地址
  HostPort get hostPort;
  @override
  @JsonKey(ignore: true)
  _$$RequesterClientImplCopyWith<_$RequesterClientImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
