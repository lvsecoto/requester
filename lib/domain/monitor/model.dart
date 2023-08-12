import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:requester/domain/log/log.dart';

part 'model.freezed.dart';

@freezed
sealed class MonitorLog with _$MonitorLog {
  const factory MonitorLog.Request({
    required String id,

    /// 日志发生时间
    required DateTime time,

    /// 请求日志
    required LogRequest logRequest,

    /// 响应日志，可能为空，因为正在请求中
    LogResponse? logResponse,

    /// 响应日志，可能为空，因为正在请求中
    LogException? logException,
  }) = MonitorLogRequest;

  /// 一个分割线
  const factory MonitorLog.divider({
    required Color color,
    required DateTime time,
  }) = MonitorLogDivider;
}
