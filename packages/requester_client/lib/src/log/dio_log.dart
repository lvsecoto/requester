import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:requester_client/rpc.dart' as rpc;
import 'package:uuid/v1.dart';

import 'log.dart';

class RequesterLogDioInterceptor extends Interceptor {
  RequesterLogDioInterceptor(this.logProvider);

  final LogProvider logProvider;

  static const _kLogId = 'log_id';
  static const _kLogTime = 'log_time';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
    final logId = const UuidV1().generate();
    final now = DateTime.now();
    options.extra = {
      ...options.extra,
      _kLogId: logId,
      _kLogTime: now,
    };

    final data = options.data;
    options.path;

    final uri = options.uri;
    final path = uri.replace(queryParameters: {}).normalizePath().toString();
    final query = uri.queryParameters;

    final logRequest = rpc.LogRequest(
      id: logId,
      path: path,
      queries: query,
      time: rpc.Int64(now.millisecondsSinceEpoch),
      headers:
          options.headers.map((key, value) => MapEntry(key, value.toString())),
      method: options.method,
      body: _captureBody(data),
    );
    logProvider.client?.sendRequest(logRequest);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);

    final logId = response.requestOptions.extra[_kLogId]!;
    DateTime requestTime = response.requestOptions.extra[_kLogTime]!;
    final logResponse = rpc.LogResponse(
      id: logId,
      spentTime: DateTime.now().difference(requestTime).inMilliseconds,
      code: response.statusCode,
      body: _captureBody(response.data),
    );
    logProvider.client?.sendResponse(logResponse);
  }

  String _captureBody(data) {
    return switch (data) {
      String() || Map<String, dynamic>() || List<dynamic>() => jsonEncode(data),
      null => '',
      _ => data.runtimeType.toString(),
    };
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    final logId = err.requestOptions.extra[_kLogId]!;
    final logResponse = rpc.LogResponse(
      id: logId,
      code: err.response?.statusCode ?? -1,
      body: err.response != null ? _captureBody(err.response!.data) : err.error.toString(),
      error: err.type.toString(),
    );
    logProvider.client?.sendResponse(logResponse);
  }
}
