import 'package:dio/dio.dart';
import 'package:requester_common/requester_common.dart';

import 'override.dart';

class RequesterOverrideDioInterceptor extends Interceptor {
  RequesterOverrideDioInterceptor(
    this.overrideProvider,
  );

  final OverrideProvider overrideProvider;

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    final overrides = await overrideProvider.getOverrideList();
    final matched = overrides.cast<OverrideRequest?>().firstWhere((it) {
      final requestUri = response.requestOptions.uri;
      final overrideUri = Uri.tryParse(it!.matcher.path);
      if (overrideUri == null) {
        return false;
      } else {
        final matchedHostAndPath = requestUri.host == overrideUri.host &&
            requestUri.path == overrideUri.path;

        if (!matchedHostAndPath) return false;

        if (overrideUri.hasQuery) {
          return requestUri.queryParameters.entries.any((query) {
            final valueMatcher = overrideUri.queryParameters[query.key];
            if (valueMatcher == null) {
              // 匹配的字段不存在，就当匹配了
              return true;
            }
            return RegExp(valueMatcher.replaceAll('*', r'(.*)'), dotAll: true)
                .hasMatch(query.key);
          });
        } else {
          return true;
        }
      }
    }, orElse: () => null);

    if (matched != null) {
      if (response.requestOptions.responseType == ResponseType.json) {
        response.data = tryJsonDecode(matched.action.responseBody) ??
            matched.action.responseBody ??
            response.data;
      } else {
        response.data = matched.action.responseBody ?? response.data;
      }
      response.statusCode = matched.action.responseCode ?? response.statusCode;
      handler.next(response);
    } else {
      handler.next(response);
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final overrides = await overrideProvider.getOverrideList();
    final matched = overrides.cast<OverrideRequest?>().firstWhere((it) {
      final requestUri = err.requestOptions.uri;
      final overrideUri = Uri.tryParse(it!.matcher.path);
      if (overrideUri == null) {
        return false;
      } else {
        final matchedHostAndPath = requestUri.host == overrideUri.host &&
            requestUri.path == overrideUri.path;

        if (!matchedHostAndPath) return false;

        if (overrideUri.queryParameters.isNotEmpty) {
          return requestUri.queryParameters.entries.any((query) {
            final valueMatcher = overrideUri.queryParameters[query.key];
            if (valueMatcher == null) {
              // 匹配的字段不存在，就当匹配了
              return true;
            }
            return RegExp(valueMatcher.replaceAll('*', r'(.*)'), dotAll: true)
                .hasMatch(query.value);
          });
        } else {
          return false;
        }
      }
    }, orElse: () => null);

    if (matched != null) {
      final response = err.response;
      if (response != null) {
        if (err.requestOptions.responseType == ResponseType.json) {
          response.data = tryJsonDecode(matched.action.responseBody) ??
              matched.action.responseBody ??
              response.data;
        } else {
          response.data = matched.action.responseBody ?? response.data;
        }
        response.statusCode =
            matched.action.responseCode ?? response.statusCode;
      }
      handler.next(err);
    } else {
      super.onError(err, handler);
    }
  }
}
