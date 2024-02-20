// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'host_port.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HostPort {
  String get host => throw _privateConstructorUsedError;
  int get port => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HostPortCopyWith<HostPort> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HostPortCopyWith<$Res> {
  factory $HostPortCopyWith(HostPort value, $Res Function(HostPort) then) =
      _$HostPortCopyWithImpl<$Res, HostPort>;
  @useResult
  $Res call({String host, int port});
}

/// @nodoc
class _$HostPortCopyWithImpl<$Res, $Val extends HostPort>
    implements $HostPortCopyWith<$Res> {
  _$HostPortCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? host = null,
    Object? port = null,
  }) {
    return _then(_value.copyWith(
      host: null == host
          ? _value.host
          : host // ignore: cast_nullable_to_non_nullable
              as String,
      port: null == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HostPortImplCopyWith<$Res>
    implements $HostPortCopyWith<$Res> {
  factory _$$HostPortImplCopyWith(
          _$HostPortImpl value, $Res Function(_$HostPortImpl) then) =
      __$$HostPortImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String host, int port});
}

/// @nodoc
class __$$HostPortImplCopyWithImpl<$Res>
    extends _$HostPortCopyWithImpl<$Res, _$HostPortImpl>
    implements _$$HostPortImplCopyWith<$Res> {
  __$$HostPortImplCopyWithImpl(
      _$HostPortImpl _value, $Res Function(_$HostPortImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? host = null,
    Object? port = null,
  }) {
    return _then(_$HostPortImpl(
      host: null == host
          ? _value.host
          : host // ignore: cast_nullable_to_non_nullable
              as String,
      port: null == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$HostPortImpl extends _HostPort {
  const _$HostPortImpl({required this.host, required this.port}) : super._();

  @override
  final String host;
  @override
  final int port;

  @override
  String toString() {
    return 'HostPort(host: $host, port: $port)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HostPortImpl &&
            (identical(other.host, host) || other.host == host) &&
            (identical(other.port, port) || other.port == port));
  }

  @override
  int get hashCode => Object.hash(runtimeType, host, port);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HostPortImplCopyWith<_$HostPortImpl> get copyWith =>
      __$$HostPortImplCopyWithImpl<_$HostPortImpl>(this, _$identity);
}

abstract class _HostPort extends HostPort {
  const factory _HostPort(
      {required final String host, required final int port}) = _$HostPortImpl;
  const _HostPort._() : super._();

  @override
  String get host;
  @override
  int get port;
  @override
  @JsonKey(ignore: true)
  _$$HostPortImplCopyWith<_$HostPortImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
