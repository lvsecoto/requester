import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:requester/domain/log/log.dart';

class TestClient {
  late Dio _dio;

  TestClient() {
    _dio = Dio()
      ..interceptors.addAll(
        [RequesterLogInterceptor()],
      );
  }

  void test() {
    _dio.get('https://www.baidu.com');
  }
}
