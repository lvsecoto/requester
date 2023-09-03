import 'dart:convert';
import 'dart:io';

import 'package:dartx/dartx.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'log.freezed.dart';
part 'log.g.dart';

class RequesterLogInterceptor extends Interceptor {
  RequesterLogInterceptor({
    this.hostPort = 'localhost:5000',
  });

  /// 记录请求时的端口
  static const kRequestPort = 'request_port';

  /// 端口配置
  final String? hostPort;

  void onDispose() {}

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final hostPort = this.hostPort;
    if (hostPort != null) {
      final id = _uuid.v1();
      final newOptions = options.copyWith(extra: {
        ...options.extra,
        'requester_id': id,
        kRequestPort: hostPort,
      });
      () async {
        await _sendData(
          jsonEncode(
            Log(
              id: id,
              element: LogElement.fromRequest(options),
            ).toJson(),
          ),
          hostPort,
        );
      }();
      super.onRequest(newOptions, handler);
    } else {
      super.onRequest(options, handler);
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final hostPort = response.requestOptions.extra[kRequestPort];
    if (hostPort != null) {
      final id = response.requestOptions.extra['requester_id'];
      _sendData(
        jsonEncode(
          Log(
            id: id,
            element: LogElement.fromResponse(response),
          ),
        ),
        hostPort,
      );
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final hostPort = err.requestOptions.extra[kRequestPort];
    if (hostPort != null) {
      final id = err.requestOptions.extra['requester_id'];
      _sendData(
        jsonEncode(
          Log(
            id: id,
            element: LogElement.fromException(err),
          ).toJson(),
        ),
        hostPort,
      );
    }
    super.onError(err, handler);
  }

  Future<void> _sendData(String data, String hostPort) async {
    try {
      final segments = hostPort.split(':');
      final socket = await Socket.connect(segments.first, segments.second.toInt());
      socket.add(data.toUtf8());
      await socket.close();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

const _uuid = Uuid();

@freezed
class Log with _$Log {
  const factory Log({
    required String id,
    required LogElement element,
  }) = _Log;

  factory Log.fromJson(Map<String, dynamic> json) => _$LogFromJson(json);
}

@freezed
sealed class LogElement with _$LogElement {
  /// 请求日志
  const factory LogElement.request({
    required String uri,
    required String method,
    required String data,
    required Map<String, String> headers,

    /// 请求时间
    required DateTime time,
  }) = LogRequest;

  static LogRequest fromRequest(RequestOptions request) {
    final requestData = request.data;
    String logData = '';
    if (requestData is Map) {
      logData = jsonEncode(requestData);
    } else if (requestData is String) {
      logData = requestData;
    }
    return LogRequest(
        uri: request.uri.toString(),
        method: request.method,
        data: logData,
        headers: request.headers.mapValues((it) => it.value.toString()),
        time: DateTime.now());
  }

  const factory LogElement.response({
    required int? statusCode,
    required String data,
    required Map<String, List<String>> headers,

    /// 响应时间
    required DateTime time,
  }) = LogResponse;

  static LogResponse fromResponse(Response response) {
    final data = response.data;
    String logData = '';
    if (data is Map) {
      logData = jsonEncode(data);
    } else if (data is String) {
      logData = data;
    }
    return LogResponse(
      statusCode: response.statusCode,
      data: logData,
      headers: response.headers.map,
      time: DateTime.now(),
    );
  }

  const factory LogElement.error({
    required DioExceptionType type,
    required DateTime time,
  }) = LogException;

  static LogException fromException(DioException exception) {
    return LogException(
      type: exception.type,
      time: DateTime.now(),
    );
  }

  factory LogElement.fromJson(Map<String, dynamic> json) =>
      _$LogElementFromJson(json);
}
