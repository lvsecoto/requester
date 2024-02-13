import 'package:curl_converter/curl_converter.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:requester/domain/log/log.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@Riverpod(dependencies: [])
int requestLogId(RequestLogIdRef ref) {
  throw UnimplementedError();
}

LogRequest? loadLogRequest(WidgetRef ref) {
  return null;
  // final requestId = ref.watch(requestIdProvider);
  // return ref.watch(getMonitorRequestProvider(requestId)).valueOrNull;
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
