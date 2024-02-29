// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'override.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OverrideRequest _$OverrideRequestFromJson(Map<String, dynamic> json) {
  return _OverrideRequest.fromJson(json);
}

/// @nodoc
mixin _$OverrideRequest {
  String? get id => throw _privateConstructorUsedError;

  /// 备注，方便可视化
  String get remark => throw _privateConstructorUsedError;

  /// 是否启用
  bool get isEnabled => throw _privateConstructorUsedError;
  OverrideRequestMatcher get matcher => throw _privateConstructorUsedError;
  OverrideRequestAction get action => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OverrideRequestCopyWith<OverrideRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OverrideRequestCopyWith<$Res> {
  factory $OverrideRequestCopyWith(
          OverrideRequest value, $Res Function(OverrideRequest) then) =
      _$OverrideRequestCopyWithImpl<$Res, OverrideRequest>;
  @useResult
  $Res call(
      {String? id,
      String remark,
      bool isEnabled,
      OverrideRequestMatcher matcher,
      OverrideRequestAction action});

  $OverrideRequestMatcherCopyWith<$Res> get matcher;
  $OverrideRequestActionCopyWith<$Res> get action;
}

/// @nodoc
class _$OverrideRequestCopyWithImpl<$Res, $Val extends OverrideRequest>
    implements $OverrideRequestCopyWith<$Res> {
  _$OverrideRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? remark = null,
    Object? isEnabled = null,
    Object? matcher = null,
    Object? action = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      remark: null == remark
          ? _value.remark
          : remark // ignore: cast_nullable_to_non_nullable
              as String,
      isEnabled: null == isEnabled
          ? _value.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      matcher: null == matcher
          ? _value.matcher
          : matcher // ignore: cast_nullable_to_non_nullable
              as OverrideRequestMatcher,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as OverrideRequestAction,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $OverrideRequestMatcherCopyWith<$Res> get matcher {
    return $OverrideRequestMatcherCopyWith<$Res>(_value.matcher, (value) {
      return _then(_value.copyWith(matcher: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $OverrideRequestActionCopyWith<$Res> get action {
    return $OverrideRequestActionCopyWith<$Res>(_value.action, (value) {
      return _then(_value.copyWith(action: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OverrideRequestImplCopyWith<$Res>
    implements $OverrideRequestCopyWith<$Res> {
  factory _$$OverrideRequestImplCopyWith(_$OverrideRequestImpl value,
          $Res Function(_$OverrideRequestImpl) then) =
      __$$OverrideRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String remark,
      bool isEnabled,
      OverrideRequestMatcher matcher,
      OverrideRequestAction action});

  @override
  $OverrideRequestMatcherCopyWith<$Res> get matcher;
  @override
  $OverrideRequestActionCopyWith<$Res> get action;
}

/// @nodoc
class __$$OverrideRequestImplCopyWithImpl<$Res>
    extends _$OverrideRequestCopyWithImpl<$Res, _$OverrideRequestImpl>
    implements _$$OverrideRequestImplCopyWith<$Res> {
  __$$OverrideRequestImplCopyWithImpl(
      _$OverrideRequestImpl _value, $Res Function(_$OverrideRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? remark = null,
    Object? isEnabled = null,
    Object? matcher = null,
    Object? action = null,
  }) {
    return _then(_$OverrideRequestImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      remark: null == remark
          ? _value.remark
          : remark // ignore: cast_nullable_to_non_nullable
              as String,
      isEnabled: null == isEnabled
          ? _value.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      matcher: null == matcher
          ? _value.matcher
          : matcher // ignore: cast_nullable_to_non_nullable
              as OverrideRequestMatcher,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as OverrideRequestAction,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OverrideRequestImpl implements _OverrideRequest {
  const _$OverrideRequestImpl(
      {this.id,
      this.remark = '',
      this.isEnabled = true,
      required this.matcher,
      required this.action});

  factory _$OverrideRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$OverrideRequestImplFromJson(json);

  @override
  final String? id;

  /// 备注，方便可视化
  @override
  @JsonKey()
  final String remark;

  /// 是否启用
  @override
  @JsonKey()
  final bool isEnabled;
  @override
  final OverrideRequestMatcher matcher;
  @override
  final OverrideRequestAction action;

  @override
  String toString() {
    return 'OverrideRequest(id: $id, remark: $remark, isEnabled: $isEnabled, matcher: $matcher, action: $action)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OverrideRequestImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.remark, remark) || other.remark == remark) &&
            (identical(other.isEnabled, isEnabled) ||
                other.isEnabled == isEnabled) &&
            (identical(other.matcher, matcher) || other.matcher == matcher) &&
            (identical(other.action, action) || other.action == action));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, remark, isEnabled, matcher, action);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OverrideRequestImplCopyWith<_$OverrideRequestImpl> get copyWith =>
      __$$OverrideRequestImplCopyWithImpl<_$OverrideRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OverrideRequestImplToJson(
      this,
    );
  }
}

abstract class _OverrideRequest implements OverrideRequest {
  const factory _OverrideRequest(
      {final String? id,
      final String remark,
      final bool isEnabled,
      required final OverrideRequestMatcher matcher,
      required final OverrideRequestAction action}) = _$OverrideRequestImpl;

  factory _OverrideRequest.fromJson(Map<String, dynamic> json) =
      _$OverrideRequestImpl.fromJson;

  @override
  String? get id;
  @override

  /// 备注，方便可视化
  String get remark;
  @override

  /// 是否启用
  bool get isEnabled;
  @override
  OverrideRequestMatcher get matcher;
  @override
  OverrideRequestAction get action;
  @override
  @JsonKey(ignore: true)
  _$$OverrideRequestImplCopyWith<_$OverrideRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OverrideRequestMatcher _$OverrideRequestMatcherFromJson(
    Map<String, dynamic> json) {
  return _OverrideRequestMatcher.fromJson(json);
}

/// @nodoc
mixin _$OverrideRequestMatcher {
  String get path => throw _privateConstructorUsedError;
  String? get method => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OverrideRequestMatcherCopyWith<OverrideRequestMatcher> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OverrideRequestMatcherCopyWith<$Res> {
  factory $OverrideRequestMatcherCopyWith(OverrideRequestMatcher value,
          $Res Function(OverrideRequestMatcher) then) =
      _$OverrideRequestMatcherCopyWithImpl<$Res, OverrideRequestMatcher>;
  @useResult
  $Res call({String path, String? method});
}

/// @nodoc
class _$OverrideRequestMatcherCopyWithImpl<$Res,
        $Val extends OverrideRequestMatcher>
    implements $OverrideRequestMatcherCopyWith<$Res> {
  _$OverrideRequestMatcherCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
    Object? method = freezed,
  }) {
    return _then(_value.copyWith(
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      method: freezed == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OverrideRequestMatcherImplCopyWith<$Res>
    implements $OverrideRequestMatcherCopyWith<$Res> {
  factory _$$OverrideRequestMatcherImplCopyWith(
          _$OverrideRequestMatcherImpl value,
          $Res Function(_$OverrideRequestMatcherImpl) then) =
      __$$OverrideRequestMatcherImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String path, String? method});
}

/// @nodoc
class __$$OverrideRequestMatcherImplCopyWithImpl<$Res>
    extends _$OverrideRequestMatcherCopyWithImpl<$Res,
        _$OverrideRequestMatcherImpl>
    implements _$$OverrideRequestMatcherImplCopyWith<$Res> {
  __$$OverrideRequestMatcherImplCopyWithImpl(
      _$OverrideRequestMatcherImpl _value,
      $Res Function(_$OverrideRequestMatcherImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
    Object? method = freezed,
  }) {
    return _then(_$OverrideRequestMatcherImpl(
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      method: freezed == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OverrideRequestMatcherImpl implements _OverrideRequestMatcher {
  const _$OverrideRequestMatcherImpl({required this.path, this.method});

  factory _$OverrideRequestMatcherImpl.fromJson(Map<String, dynamic> json) =>
      _$$OverrideRequestMatcherImplFromJson(json);

  @override
  final String path;
  @override
  final String? method;

  @override
  String toString() {
    return 'OverrideRequestMatcher(path: $path, method: $method)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OverrideRequestMatcherImpl &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.method, method) || other.method == method));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, path, method);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OverrideRequestMatcherImplCopyWith<_$OverrideRequestMatcherImpl>
      get copyWith => __$$OverrideRequestMatcherImplCopyWithImpl<
          _$OverrideRequestMatcherImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OverrideRequestMatcherImplToJson(
      this,
    );
  }
}

abstract class _OverrideRequestMatcher implements OverrideRequestMatcher {
  const factory _OverrideRequestMatcher(
      {required final String path,
      final String? method}) = _$OverrideRequestMatcherImpl;

  factory _OverrideRequestMatcher.fromJson(Map<String, dynamic> json) =
      _$OverrideRequestMatcherImpl.fromJson;

  @override
  String get path;
  @override
  String? get method;
  @override
  @JsonKey(ignore: true)
  _$$OverrideRequestMatcherImplCopyWith<_$OverrideRequestMatcherImpl>
      get copyWith => throw _privateConstructorUsedError;
}

OverrideRequestAction _$OverrideRequestActionFromJson(
    Map<String, dynamic> json) {
  return OverrideRequestActionReplace.fromJson(json);
}

/// @nodoc
mixin _$OverrideRequestAction {
  int? get responseCode => throw _privateConstructorUsedError;
  String? get responseBody => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? responseCode, String? responseBody) replace,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? responseCode, String? responseBody)? replace,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? responseCode, String? responseBody)? replace,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OverrideRequestActionReplace value) replace,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OverrideRequestActionReplace value)? replace,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OverrideRequestActionReplace value)? replace,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OverrideRequestActionCopyWith<OverrideRequestAction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OverrideRequestActionCopyWith<$Res> {
  factory $OverrideRequestActionCopyWith(OverrideRequestAction value,
          $Res Function(OverrideRequestAction) then) =
      _$OverrideRequestActionCopyWithImpl<$Res, OverrideRequestAction>;
  @useResult
  $Res call({int? responseCode, String? responseBody});
}

/// @nodoc
class _$OverrideRequestActionCopyWithImpl<$Res,
        $Val extends OverrideRequestAction>
    implements $OverrideRequestActionCopyWith<$Res> {
  _$OverrideRequestActionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? responseCode = freezed,
    Object? responseBody = freezed,
  }) {
    return _then(_value.copyWith(
      responseCode: freezed == responseCode
          ? _value.responseCode
          : responseCode // ignore: cast_nullable_to_non_nullable
              as int?,
      responseBody: freezed == responseBody
          ? _value.responseBody
          : responseBody // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OverrideRequestActionReplaceImplCopyWith<$Res>
    implements $OverrideRequestActionCopyWith<$Res> {
  factory _$$OverrideRequestActionReplaceImplCopyWith(
          _$OverrideRequestActionReplaceImpl value,
          $Res Function(_$OverrideRequestActionReplaceImpl) then) =
      __$$OverrideRequestActionReplaceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? responseCode, String? responseBody});
}

/// @nodoc
class __$$OverrideRequestActionReplaceImplCopyWithImpl<$Res>
    extends _$OverrideRequestActionCopyWithImpl<$Res,
        _$OverrideRequestActionReplaceImpl>
    implements _$$OverrideRequestActionReplaceImplCopyWith<$Res> {
  __$$OverrideRequestActionReplaceImplCopyWithImpl(
      _$OverrideRequestActionReplaceImpl _value,
      $Res Function(_$OverrideRequestActionReplaceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? responseCode = freezed,
    Object? responseBody = freezed,
  }) {
    return _then(_$OverrideRequestActionReplaceImpl(
      responseCode: freezed == responseCode
          ? _value.responseCode
          : responseCode // ignore: cast_nullable_to_non_nullable
              as int?,
      responseBody: freezed == responseBody
          ? _value.responseBody
          : responseBody // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OverrideRequestActionReplaceImpl
    implements OverrideRequestActionReplace {
  const _$OverrideRequestActionReplaceImpl(
      {this.responseCode, this.responseBody});

  factory _$OverrideRequestActionReplaceImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$OverrideRequestActionReplaceImplFromJson(json);

  @override
  final int? responseCode;
  @override
  final String? responseBody;

  @override
  String toString() {
    return 'OverrideRequestAction.replace(responseCode: $responseCode, responseBody: $responseBody)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OverrideRequestActionReplaceImpl &&
            (identical(other.responseCode, responseCode) ||
                other.responseCode == responseCode) &&
            (identical(other.responseBody, responseBody) ||
                other.responseBody == responseBody));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, responseCode, responseBody);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OverrideRequestActionReplaceImplCopyWith<
          _$OverrideRequestActionReplaceImpl>
      get copyWith => __$$OverrideRequestActionReplaceImplCopyWithImpl<
          _$OverrideRequestActionReplaceImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? responseCode, String? responseBody) replace,
  }) {
    return replace(responseCode, responseBody);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? responseCode, String? responseBody)? replace,
  }) {
    return replace?.call(responseCode, responseBody);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? responseCode, String? responseBody)? replace,
    required TResult orElse(),
  }) {
    if (replace != null) {
      return replace(responseCode, responseBody);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OverrideRequestActionReplace value) replace,
  }) {
    return replace(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OverrideRequestActionReplace value)? replace,
  }) {
    return replace?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OverrideRequestActionReplace value)? replace,
    required TResult orElse(),
  }) {
    if (replace != null) {
      return replace(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$OverrideRequestActionReplaceImplToJson(
      this,
    );
  }
}

abstract class OverrideRequestActionReplace implements OverrideRequestAction {
  const factory OverrideRequestActionReplace(
      {final int? responseCode,
      final String? responseBody}) = _$OverrideRequestActionReplaceImpl;

  factory OverrideRequestActionReplace.fromJson(Map<String, dynamic> json) =
      _$OverrideRequestActionReplaceImpl.fromJson;

  @override
  int? get responseCode;
  @override
  String? get responseBody;
  @override
  @JsonKey(ignore: true)
  _$$OverrideRequestActionReplaceImplCopyWith<
          _$OverrideRequestActionReplaceImpl>
      get copyWith => throw _privateConstructorUsedError;
}
