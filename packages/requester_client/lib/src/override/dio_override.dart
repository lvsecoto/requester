import 'package:dio/dio.dart';
import 'package:requester_common/requester_common.dart';

import 'override.dart';

class RequesterOverrideDioInterceptor extends Interceptor {
  RequesterOverrideDioInterceptor(
    this.overrideProvider,
  );

  static const kRequesterOverridden = 'requester_overridden';

  final OverrideProvider overrideProvider;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    super.onRequest(options, handler);
    // OverrideRequest? matched =
    await _match(options);
    /// todo 对请求的操作
    /// _actionToRequest(options, matched);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    final matched = await _match(response.requestOptions);
    if (matched != null) {
      _actionToResponse(matched, response);
      handler.next(response);
    } else {
      handler.next(response);
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final matched = await _match(err.requestOptions);
    if (matched != null) {
      final response = err.response;
      _actionToResponse(matched, response);
      handler.next(err);
    } else {
      super.onError(err, handler);
    }
  }

  /// 先从[requestOptions.extra]找，然后再在
  /// 在[overrideProvider.getOverrideList]中找到符合[requestOptions]的[OverrideRequest]
  ///
  /// 找不到就返回null
  Future<OverrideRequest?> _match(RequestOptions requestOptions) async {
    var matched = requestOptions.extra[kRequesterOverridden] as OverrideRequest?;
    if (matched != null) {
      return matched;
    }
    final requestUri = requestOptions.uri;
    final overrides = await overrideProvider.getOverrideList();
    matched = overrides.cast<OverrideRequest?>().firstWhere((it) {
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
    requestOptions.extra[kRequesterOverridden] = matched;
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
