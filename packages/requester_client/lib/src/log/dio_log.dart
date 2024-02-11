import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:requester_client/rpc.dart' as rpc;
import 'package:uuid/v1.dart';

import 'log.dart';

class RequesterLogDioInterceptor extends Interceptor {
  RequesterLogDioInterceptor(this.logProvider);

  final LogProvider logProvider;

  static const _kLogId = 'log_id';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
    final logId = const UuidV1().generate();
    options.extra = {
      ...options.extra,
      _kLogId: logId,
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
    final logResponse = rpc.LogResponse(
      id: logId,
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
      error: EnumToString.convertToString(err.type),
    );
    logProvider.client?.sendResponse(logResponse);
  }
}
