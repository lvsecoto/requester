import 'package:curl_converter/curl_converter.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:requester/domain/client/client.dart';
import 'package:requester/domain/document/document.dart';
import 'package:requester/domain/log/log.dart';
import 'package:requester/ui/log/common/common.dart';
import 'package:requester_client/requester_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

/// 日志Id
@Riverpod(dependencies: [])
int requestLogId(RequestLogIdRef ref) {
  throw UnimplementedError();
}

/// 加载请求日志
LogRequest? watchLogRequest(WidgetRef ref) {
  final requestId = ref.watch(requestLogIdProvider);
  final provider = ref.watch(logManagerProvider).provideLoadLog(requestId);
  return ref.watch(provider).valueOrNull as LogRequest?;
}

LogRequest? getLogRequest(WidgetRef ref) {
  final requestId = ref.read(requestLogIdProvider);
  final provider = ref.read(logManagerProvider).provideLoadLog(requestId);
  return ref.read(provider).valueOrNull as LogRequest?;
}

/// 加载请求日志分析
@Riverpod(dependencies: [requestLogId])
class LoadAnalyzeLogRequest extends _$LoadAnalyzeLogRequest {
  @override
  LogRequestAnalysis? build() {
    final requestId = ref.watch(requestLogIdProvider);
    final provider = ref.watch(logManagerProvider).provideLoadLog(requestId);
    final logRequest = ref.watch(provider).valueOrNull as LogRequest?;
    if (logRequest == null) {
      return null;
    }

    final documentProvider =
        ref.watch(documentManagerProvider).provideAnalyzeLogRequest(logRequest);
    // 如果请求日志更新，那么它依然会继续使用更新之前加载好的分析结果，避免界面发生显示跳动
    return ref.watch(documentProvider).valueOrNull ?? stateOrNull;
  }
}

/// 加载请求参数
Map<String, ParametersTableValue> watchLogRequestQueries(
  WidgetRef ref,
) {
  final request = watchLogRequest(ref);
  if (request == null) {
    return {};
  }
  final documentQuery = ref.watch(loadAnalyzeLogRequestProvider)?.queries;
  return _analyzeParameterData(documentQuery, request.requestQueries);
}

/// 加载请求头
Map<String, ParametersTableValue> watchLogRequestHeaders(
  WidgetRef ref,
) {
  final request = watchLogRequest(ref);
  if (request == null) {
    return {};
  }
  final documentHeaders = ref.watch(loadAnalyzeLogRequestProvider)?.headers;
  return _analyzeParameterData(documentHeaders, request.requestHeaders);
}

/// 用文档[document]分析数据集合[data]
Map<String, ParametersTableValue> _analyzeParameterData(
  Map<String, FieldAnalysis>? document,
  Map<String, String> data,
) {
  if (document == null) {
    return data.map(
      (key, value) => MapEntry(
        key,
        ParametersTableValue(data: value),
      ),
    );
  }
  return {
    ...document.map((key, fieldAnalysis) => MapEntry(
          key,
          ParametersTableValue(
            fieldAnalysis: fieldAnalysis,
            data: data[key],
          ),
        )),
    ...data
        .filterNot((it) => document.keys.contains(it.key))
        .map((key, data) => MapEntry(
              key,
              ParametersTableValue(
                isRedundant: true,
                data: data,
              ),
            ))
  };
}

/// 加载请求体
DataWidgetData watchLogRequestBody(
  WidgetRef ref,
) {
  final request = watchLogRequest(ref);
  if (request == null) {
    return DataWidgetData(data: '');
  }
  final documentBodies = ref.watch(loadAnalyzeLogRequestProvider)?.requestBody;
  return DataWidgetData(
    data: request.requestBody,
    objectAnalysis: documentBodies,
  );
}

/// 加载返回体
DataWidgetData loadLogResponseBody(
  WidgetRef ref,
) {
  final request = watchLogRequest(ref);
  if (request == null) {
    return DataWidgetData(data: '');
  }
  final documentBodies = ref.watch(loadAnalyzeLogRequestProvider)?.responseBody;
  return DataWidgetData(
    data: request.requestResponse?.body ?? '',
    objectAnalysis: documentBodies?[request.requestResponse?.code.toString()],
  );
}

final kDefaultMonitorSplitAreas = [
  Area(minimalSize: 200),
  Area(minimalSize: 200)
];

@riverpod
Raw<MultiSplitViewController> splitViewController(SplitViewControllerRef ref) {
  return MultiSplitViewController(areas: kDefaultMonitorSplitAreas);
}

/// 获取请求curl
String? getRequestCurl(WidgetRef ref) {
  final request = getLogRequest(ref);
  if (request == null) {
    return null;
  }
  final curlString = Curl(
    uri: Uri.parse(getRequestUrl(ref)!),
    data: request.requestBody,
    headers: request.requestHeaders,
    method: request.requestMethod,
  ).toCurlString();

  return curlString;
}

/// 获取请求url
String? getRequestUrl(WidgetRef ref) {
  final request = getLogRequest(ref);
  if (request == null) {
    return null;
  }
  return Uri.tryParse(request.requestPath)
      ?.replace(queryParameters: request.requestQueries)
      .toString()
      .removeSuffix('?');
}

/// 加载发送此日志的客户端
RequesterClient? getLogRequesterClient(WidgetRef ref) {
  final request = getLogRequest(ref);
  if (request == null) {
    return null;
  }
  final provider =
      ref.read(clientManagerProvider).provideRequesterClient(request.clientUid);
  return ref.read(provider).valueOrNull;
}

/// 观察发送此日志的客户端
RequesterClient? watchLogRequesterClient(WidgetRef ref) {
  final request = watchLogRequest(ref);
  if (request == null) {
    return null;
  }
  final provider = ref
      .watch(clientManagerProvider)
      .provideRequesterClient(request.clientUid);
  return ref.watch(provider).valueOrNull;
}
