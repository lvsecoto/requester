import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:requester/domain/monitor/model.dart';
import 'package:requester/domain/monitor/monitor.dart';
import 'package:requester/domain/monitor/provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@Riverpod(dependencies: [])
String requestId(RequestIdRef ref) {
  throw UnimplementedError();
}

MonitorLogRequest? loadMonitorRequest(WidgetRef ref) {
  final requestId = ref.watch(requestIdProvider);
  return ref.watch(getMonitorRequestProvider(requestId)).valueOrNull;
}

final kDefaultMonitorSplitAreas = [
  Area(minimalSize: 200), Area(minimalSize: 200)
];

@riverpod
Raw<MultiSplitViewController> splitViewController(SplitViewControllerRef ref) {
  return MultiSplitViewController(
    areas: kDefaultMonitorSplitAreas
  );
}
