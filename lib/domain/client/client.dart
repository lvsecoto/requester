import 'package:dio/dio.dart';
import 'package:requester/domain/log/log.dart';
import 'package:requester/domain/monitor/provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'client.g.dart';

@riverpod
TestClient testClient(TestClientRef ref) {
  final hostPort = ref.watch(monitorHostPortProvider).valueOrNull;
  return TestClient(hostPort);
}

class TestClient {
  late Dio _dio;

  TestClient(String? hostPort) {
    _dio = Dio()
      ..interceptors.addAll(
        [RequesterLogInterceptor(hostPort: hostPort)],
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
