import 'package:curl_converter/curl_converter.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:requester/domain/document/document.dart';
import 'package:requester/domain/log/log.dart';
import 'package:requester/ui/monitor/common/common.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@Riverpod(dependencies: [])
int requestLogId(RequestLogIdRef ref) {
  throw UnimplementedError();
}

LogRequest? loadLogRequest(WidgetRef ref) {
  final requestId = ref.watch(requestLogIdProvider);
  final provider = ref.watch(logManagerProvider).provideLoadLog(requestId);
  return ref.watch(provider).valueOrNull as LogRequest?;
}

Map<String, ParametersTableValue> loadLogRequestQueries(
  WidgetRef ref,
) {
  final request = loadLogRequest(ref);
  if (request == null) {
    return {};
  }
  final documentProvider =
      ref.watch(documentManagerProvider).provideAnalyzeLogRequest(request);
  final documentQuery = ref.watch(documentProvider).valueOrNull?.queries;
  return _analyzeParameterData(documentQuery, request.requestQueries);
}

Map<String, ParametersTableValue> loadLogRequestHeaders(
  WidgetRef ref,
) {
  final request = loadLogRequest(ref);
  if (request == null) {
    return {};
  }
  final documentProvider =
      ref.watch(documentManagerProvider).provideAnalyzeLogRequest(request);
  final documentHeaders = ref.watch(documentProvider).valueOrNull?.headers;
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
DataWidgetData loadLogRequestBody(
  WidgetRef ref,
) {
  final request = loadLogRequest(ref);
  if (request == null) {
    return DataWidgetData(data: '');
  }
  final documentProvider =
      ref.watch(documentManagerProvider).provideAnalyzeLogRequest(request);
  final documentBodies = ref.watch(documentProvider).valueOrNull?.requestBody;
  return DataWidgetData(
    data: request.requestBody ?? '',
    objectAnalysis: documentBodies,
  );
}

DataWidgetData loadLogResponseBody(
  WidgetRef ref,
) {
  final request = loadLogRequest(ref);
  if (request == null) {
    return DataWidgetData(data: '');
  }
  final documentProvider =
      ref.watch(documentManagerProvider).provideAnalyzeLogRequest(request);
  final documentBodies = ref.watch(documentProvider).valueOrNull?.responseBody;
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

String? getRequestCurl(WidgetRef ref) {
  final request = loadLogRequest(ref);
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

String? getRequestUrl(WidgetRef ref) {
  final request = loadLogRequest(ref);
  if (request == null) {
    return null;
  }
  return Uri.tryParse(request.requestPath)?.replace(
    queryParameters: request.requestQueries
  ).toString().removeSuffix('?');
}
