import 'package:dio/dio.dart';
import 'package:requester_client/requester_client.dart';

import 'log/dio_log.dart';
import 'override/dio_override.dart';

extension RequestDioEx on RequesterClientController? {
  List<Interceptor> buildDioInterceptors() {
    if (this == null) return const [];
    return [
      RequesterOverrideDioInterceptor(this!.overrideProvider),
      RequesterLogDioInterceptor(this!.logProvider),
    ];
  }
}
