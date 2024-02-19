import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:requester_client/rpc.dart' as rpc;
import 'package:uuid/v1.dart';

import 'override.dart';

class RequesterOverrideDioInterceptor extends Interceptor {
  RequesterOverrideDioInterceptor(
    this.overrideProvider,
  );

  final OverrideProvider overrideProvider;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }
}
