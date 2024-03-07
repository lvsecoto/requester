// ignore_for_file: unused_import

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:requester_client/requester_client.dart';
import 'package:requester_client/rpc.dart' as rpc;
import 'package:requester_client/src/override/dio_override.dart';
import 'package:uuid/v1.dart';

import 'log.dart';

class RequesterLogDioInterceptor extends Interceptor {
  /// 对dio请求抓取日志
  ///
  /// 注意日志对请求，会抓取应用层对请求的处理，而对响应的抓取，则是服务器原始数据
  /// 应用层 -> (其他拦截器) -> 日志 -> 服务器 -> 日志 -> (其他拦截器) ->  应用层
  RequesterLogDioInterceptor(this.logProvider);

  final LogProvider logProvider;

  static const _kLogId = 'log_id';
  static const _kLogTime = 'log_time';

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // 先让其他拦截器处理好请求
    super.onRequest(options, handler);
    final log = await logProvider.createLog();
    options.extra = {
      ...options.extra,
      _kLogId: log.id,
      _kLogTime: DateTime.now(),
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
      log: log,
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
    final logId = response.requestOptions.extra[_kLogId]!;
    DateTime requestTime = response.requestOptions.extra[_kLogTime]!;
    final logResponse = rpc.LogResponse(
        log: await logProvider.createLog(
          id: logId,
        ),
        spentTime: DateTime.now().difference(requestTime).inMilliseconds,
        code: response.statusCode,
        body: _captureBody(response.data),
        requestOverridden: _captureRequestOverridden(response.requestOptions));
    // 必须先抓取日志，再继续处理，不然抓取的是后面拦截器处理过的数据，不准确
    super.onResponse(response, handler);
    await logProvider.client?.sendResponse(logResponse);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    super.onError(err, handler);
    final logId = err.requestOptions.extra[_kLogId]!;
    final logResponse = rpc.LogResponse(
        log: await logProvider.createLog(
          id: logId,
        ),
        code: err.response?.statusCode ?? -1,
        body: err.response != null
            ? _captureBody(err.response!.data)
            : err.error.toString(),
        error: err.type.toString(),
        requestOverridden: _captureRequestOverridden(err.requestOptions));
    await logProvider.client?.sendResponse(logResponse);
  }

  String _captureBody(data) => switch (data) {
        String() ||
        Map<String, dynamic>() ||
        List<dynamic>() =>
          jsonEncode(data),
        null => '',
        _ => data.runtimeType.toString(),
      };

  /// 获取重载配置来日志，如果没有，返回空
  rpc.RpcJson? _captureRequestOverridden(RequestOptions options) {
    return (options.extra[RequesterOverrideDioInterceptor.kRequesterOverridden]
            as OverrideRequest?)
        ?.toJson()
        .toRpcJson()
        .jsonValue;
  }
}
