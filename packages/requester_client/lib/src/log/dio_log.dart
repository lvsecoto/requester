import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:requester_client/requester_client.dart';
import 'package:requester_client/rpc.dart' as rpc;
import 'package:requester_client/src/override/dio_override.dart';
import 'package:uuid/v1.dart';

import 'log.dart';

class RequesterLogDioInterceptor extends Interceptor {
  RequesterLogDioInterceptor(this.logProvider);

  final LogProvider logProvider;

  static const _kLogId = 'log_id';
  static const _kLogTime = 'log_time';

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
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
    var path = uri.replace(queryParameters: {}).normalizePath().toString();
    if (path.endsWith('?')) {
      path = path.substring(0, path.length - 1);
    }
    final query = uri.queryParameters;

    final logRequest = rpc.LogRequest(
      log: rpc.Log(
        id: logId,
        clientUid: await RequesterClient.getClientUid(),
        time: rpc.Int64(now.millisecondsSinceEpoch),
      ),
      path: path,
      queries: query,
      headers:
          options.headers.map((key, value) => MapEntry(key, value.toString())),
      method: options.method,
      body: _captureBody(data),
      requestOverridden: _captureRequestOverridden(options),
    );
    await logProvider.client?.sendRequest(logRequest);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    super.onResponse(response, handler);

    final logId = response.requestOptions.extra[_kLogId]!;
    DateTime requestTime = response.requestOptions.extra[_kLogTime]!;
    final logResponse = rpc.LogResponse(
      log: rpc.Log(
        id: logId,
        clientUid: await RequesterClient.getClientUid(),
        time: rpc.Int64(),
      ),
      spentTime: DateTime.now().difference(requestTime).inMilliseconds,
      code: response.statusCode,
      body: _captureBody(response.data),
      requestOverridden: _captureRequestOverridden(response.requestOptions)
    );
    await logProvider.client?.sendResponse(logResponse);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    super.onError(err, handler);
    final logId = err.requestOptions.extra[_kLogId]!;
    final logResponse = rpc.LogResponse(
      log: rpc.Log(
        id: logId,
        clientUid: await RequesterClient.getClientUid(),
        time: rpc.Int64(),
      ),
      code: err.response?.statusCode ?? -1,
      body: err.response != null
          ? _captureBody(err.response!.data)
          : err.error.toString(),
      error: err.type.toString(),
      requestOverridden: _captureRequestOverridden(err.requestOptions)
    );
    await logProvider.client?.sendResponse(logResponse);
  }

  String _captureBody(data) => switch (data) {
      String() || Map<String, dynamic>() || List<dynamic>() => jsonEncode(data),
      null => '',
      _ => data.runtimeType.toString(),
    };

  /// 获取重载配置来日志，如果没有，返回空
  rpc.RpcJson? _captureRequestOverridden(RequestOptions options) {
    return (options.extra[RequesterOverrideDioInterceptor.kRequesterOverridden]
    as OverrideRequest?)
        ?.toJson().toRpcJson().jsonValue;
  }
}
