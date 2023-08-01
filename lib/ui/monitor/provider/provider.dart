import 'package:common/common.dart';
import 'package:dartx/dartx.dart';
import 'package:requester/domain/monitor/monitor.dart';
import 'package:requester/domain/monitor/provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@riverpod
String monitor(MonitorRef ref) {
  return 'monitor';
}

@riverpod
class EditQuery extends _$EditQuery with TextEditNotifier {
  @override
  String build() {
    return super.build();
  }
}

@riverpod
Future<List<MonitorRequest>> filteredRequest(FilteredRequestRef ref) async {
  var list = ref.watch(monitorRequestListProvider).valueOrNull ?? [];
  final query = ref.watch(editQueryProvider);
  return list.filter((it) => it.logRequest.uri.contains(query)).toList();
}
