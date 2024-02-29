import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:requester_common/requester_common.dart';

part 'override.freezed.dart';

part 'override.g.dart';

class OverrideProvider {
  List<OverrideRequest>? _overrides;

  Future<List<OverrideRequest>> getOverrideList() async {
    _overrides ??= await getObject<List<OverrideRequest>>(
      'override_request_list',
      decode: (text) {
        try {
          final list = jsonDecode(text) as List;
          return list
              .cast<Map<String, dynamic>>()
              .map(OverrideRequest.fromJson)
              .toList();
        } catch (e) {
          return const [];
        }
      },
      encode: jsonEncode,
      defaultValue: const <OverrideRequest>[],
    );
    return _overrides!;
  }

  Future<void> _setOverrideList(List<OverrideRequest> overrides) async {
    await saveObject('override_request_list', overrides, encode: jsonEncode);
    _overrides = overrides;
  }

  /// 添加重载规则
  Future<void> addOverride(OverrideRequest overrideRequest) async {
    final overrides = await getOverrideList();
    await _setOverrideList([...overrides, overrideRequest]);
  }

  /// 删除重载规则
  Future<void> removeOverride(OverrideRequest overrideRequest) async {
    final overrides = await getOverrideList();
    await _setOverrideList(
      [
        ...overrides,
      ]..removeWhere((it) => it.id == overrideRequest.id),
    );
  }

  /// 更新重载规则
  Future<void> updateOverride(OverrideRequest overrideRequest) async {
    final overrides = await getOverrideList();
    final index = overrides.indexWhere((it) => it.id == overrideRequest.id);
    if (index == -1) return;
    await _setOverrideList(
      [
        ...overrides,
      ]..[index] = overrideRequest,
    );
  }
}

@freezed
class OverrideRequest with _$OverrideRequest {
  const factory OverrideRequest({
    String? id,
    /// 备注，方便可视化
    @Default('') String remark,
    /// 是否启用
    @Default(true) bool isEnabled,
    required OverrideRequestMatcher matcher,
    required OverrideRequestAction action,
  }) = _OverrideRequest;

  factory OverrideRequest.fromJson(Map<String, dynamic> json) =>
      _$OverrideRequestFromJson(json);

  static OverrideRequest? tryFromJson(Map<String, dynamic>? json) {
    try {
      return OverrideRequest.fromJson(json!);
    } catch (_) {
      return null;
    }
  }
}

@freezed
class OverrideRequestMatcher with _$OverrideRequestMatcher {
  const factory OverrideRequestMatcher({
    required String path,
    String? method,
  }) = _OverrideRequestMatcher;

  factory OverrideRequestMatcher.fromJson(Map<String, dynamic> json) =>
      _$OverrideRequestMatcherFromJson(json);
}

@freezed
class OverrideRequestAction with _$OverrideRequestAction {
  const factory OverrideRequestAction.replace({
    int? responseCode,
    String? responseBody,
  }) = OverrideRequestActionReplace;

  factory OverrideRequestAction.fromJson(Map<String, dynamic> json) =>
      _$OverrideRequestActionFromJson(json);
}
