import 'package:requester/domain/monitor/model.dart';
import 'package:requester/domain/monitor/monitor.dart';
import 'package:requester/domain/monitor/provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@Riverpod(dependencies: [])
String requestId(RequestIdRef ref) {
  throw UnimplementedError();
}

@Riverpod(dependencies: [requestId])
Future<MonitorRequest> loadMonitorRequest(LoadMonitorRequestRef ref) async {
  final requestId = ref.watch(requestIdProvider);
  final request = ref.watch(monitorRequestListProvider.select(
    (it) => it.requireValue.firstWhere(
      (it) => it.id == requestId,
    ),
  ));
  return request;
}
