import 'package:dio/dio.dart';
import 'package:requester_client/requester_client.dart';

import 'log/dio_log.dart';
import 'override/dio_override.dart';

extension RequestDioEx on RequesterClientController {
  List<Interceptor> buildDioInterceptors() {
    return [
      RequesterOverrideDioInterceptor(overrideProvider),
      RequesterLogDioInterceptor(logProvider),
    ];
  }
}
