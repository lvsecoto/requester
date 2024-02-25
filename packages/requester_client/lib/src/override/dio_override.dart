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
    final requestUri = response.requestOptions.uri;

    OverrideRequest? matched = _match(overrides, requestUri);

    if (matched != null) {
      _actionToResponse(matched, response);
      handler.next(response);
    } else {
      handler.next(response);
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final overrides = await overrideProvider.getOverrideList();
    final matched = _match(overrides, err.requestOptions.uri);

    if (matched != null) {
      final response = err.response;
      _actionToResponse(matched, response);
      handler.next(err);
    } else {
      super.onError(err, handler);
    }
  }

  /// 在[overrides]中找到符合[requestUri]的[OverrideRequest]
  ///
  /// 找不到就返回null
  OverrideRequest? _match(List<OverrideRequest> overrides, Uri requestUri) {
    final matched = overrides.cast<OverrideRequest?>().firstWhere((it) {
      final overrideUri = Uri.tryParse(it!.matcher.path);
      if (overrideUri == null) {
        return false;
      } else {
        final isMatchedHostAndPath = requestUri.host == overrideUri.host &&
            requestUri.path == overrideUri.path;

        if (!isMatchedHostAndPath) return false;

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
    return matched;
  }

  /// 用匹配中的[matched]来操作response
  void _actionToResponse(OverrideRequest matched, Response? response) {
    if (response != null) {
      if (response.requestOptions.responseType == ResponseType.json) {
        response.data = tryJsonDecode(matched.action.responseBody) ??
            matched.action.responseBody ??
            response.data;
      } else {
        response.data = matched.action.responseBody ?? response.data;
      }
      response.statusCode = matched.action.responseCode ?? response.statusCode;
    }
  }
}
