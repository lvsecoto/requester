import 'package:common/common.dart';
import 'package:dartx/dartx.dart';
import 'package:requester/domain/monitor/monitor.dart';
import 'package:requester/domain/monitor/provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@riverpod
class EditQuery extends _$EditQuery with TextEditNotifier {
  @override
  String build() {
    return super.build();
  }
}

@riverpod
Future<List<MonitorLog>> filteredRequest(FilteredRequestRef ref) async {
  final query = ref.watch(editQueryProvider).trim();
  var all = ref.watch(monitorRequestListProvider).valueOrNull ?? [];
  if (query.isEmpty) {
    return all;
  }
  return all
      .filter((it) => switch (it) {
            MonitorLogRequest() => it.logRequest.uri.contains(query) ||
                it.logRequest.data.contains(query) ||
                (it.logResponse?.data.contains(query) ?? false),
            _ => true,
          })
      .toList();
}
