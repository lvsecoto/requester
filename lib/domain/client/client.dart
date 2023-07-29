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

  void testGet() {
    _dio.get('http://httpbin.org/get', queryParameters: {
      'a': 'b',
      'c': 'd',
    });
  }

  void testPost() {
    _dio.post('http://httpbin.org/get', data: {
      'a': 'b',
      'c': 'd',
    });
  }

}
