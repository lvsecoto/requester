import 'package:curl_converter/curl_converter.dart';
import 'package:flutter/services.dart';
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
  if (documentQuery == null) {
    return request.requestQueries.map((key, value) => MapEntry(
          key,
          ParametersTableValue(
            fieldAnalysis: null,
            data: value,
          ),
        ));
  } else {
    return request.requestQueries.map((key, value) => MapEntry(
          key,
          ParametersTableValue(
            fieldAnalysis: documentQuery[key],
            data: value,
          ),
        ));
  }
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
  if (documentHeaders == null) {
    return request.requestQueries.map((key, value) => MapEntry(
          key,
          ParametersTableValue(
            fieldAnalysis: null,
            data: value,
          ),
        ));
  } else {
    return request.requestQueries.map((key, value) => MapEntry(
          key,
          ParametersTableValue(
            fieldAnalysis: documentHeaders[key],
            data: value,
          ),
        ));
  }
}

final kDefaultMonitorSplitAreas = [
  Area(minimalSize: 200),
  Area(minimalSize: 200)
];

@riverpod
Raw<MultiSplitViewController> splitViewController(SplitViewControllerRef ref) {
  return MultiSplitViewController(areas: kDefaultMonitorSplitAreas);
}

void copyCurl(WidgetRef ref) {
  // final request = loadMonitorRequest(ref)?.logRequest;
  final request = null;
  if (request == null) {
    return;
  }
  final curlString = Curl(
    uri: Uri.parse(request.uri),
    data: request.data,
    headers: request.headers,
  ).toCurlString();

  _copyToClipBoard(curlString);
}

void copyURL(WidgetRef ref) {
  return;
  final request = loadLogRequest(ref);
  if (request == null) {
    return;
  }
  // _copyToClipBoard(
  //   request.logRequest.uri,
  // );
}

void _copyToClipBoard(String text) {
  Clipboard.setData(ClipboardData(text: text));
}
