import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:requester/domain/monitor/model.dart';
import 'package:requester/domain/monitor/monitor.dart';
import 'package:requester/domain/monitor/provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@Riverpod(dependencies: [])
String requestId(RequestIdRef ref) {
  throw UnimplementedError();
}

MonitorRequest? loadMonitorRequest(WidgetRef ref) {
  final requestId = ref.watch(requestIdProvider);
  return ref.watch(getMonitorRequestProvider(requestId)).valueOrNull;
}

// @Riverpod(dependencies: [requestId])
// Future<MonitorRequest> loadMonitorRequest(LoadMonitorRequestRef ref) async {
//   final requestId = ref.watch(requestIdProvider);
//   return ref.watch(getMonitorRequestProvider(requestId).future);
// }
