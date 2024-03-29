import 'package:common/common.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:requester/domain/client/client.dart';
import 'package:requester/domain/document/document.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:requester/domain/log/log.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

export 'package:requester/domain/log/log.dart' show Log, LogRequest, LogAppState, FoldedLogs;

part 'provider.g.dart';

/// 编辑搜索关键字
@riverpod
class EditQuery extends _$EditQuery with TextEditControllerNotifier {
  @override
  String build() {
    final subject = BehaviorSubject.seeded('');
    ref.listenSelf((previous, next) {
      subject.add(next);
    });
    final sub = subject
        .throttleTime(
      const Duration(milliseconds: 500),
      trailing: true,
    )
        .listen((query) {
      ref.read(currentFilterProvider.notifier).state =
          ref.read(currentFilterProvider).copyWith(
                query: query,
              );
    });
    ref.onDispose(() {
      sub.cancel();
    });
    return super.onBuild();
  }
}

/// 当前过滤配置
@riverpod
class CurrentFilter extends _$CurrentFilter {
  @override
  LogFilter build() {
    return const LogFilter();
  }
}

/// 日志Provider
@riverpod
class WatchLogProvider extends _$WatchLogProvider {
  @override
  LogListProvider build() {
    final filter = ref.watch(currentFilterProvider);
    var provider = stateOrNull;
    List<Log> currentLogs = const [];
    if (provider != null) {
      currentLogs = ref.read(provider).data;
    }
    return ref.watch(logManagerProvider).providerLogList(filter.copyWith(
      byData: currentLogs,
    ));
  }
}

/// 操作：清除日志
Future<void> actionDeleteLog(WidgetRef ref, Log log) async {
  return ref.read(logManagerProvider).deleteLog(log);
}

/// 操作：清除日志
Future<void> actionClearLog(WidgetRef ref) async {
  return ref.read(logManagerProvider).clear();
}

/// 观察请求文档
String watchRequestDocumentSummary(WidgetRef ref, LogRequest logRequest) {
  final provider = ref.watch(documentManagerProvider).provideAnalyzeLogRequest(logRequest);
  final notNullSummary = useRef<String?>(null);
  final summary = ref.watch(provider).valueOrNull?.summary;
  if (summary != null) {
    notNullSummary.value = summary;
  }
  return notNullSummary.value ?? '';
}

/// 获取客户端描述
String? watchRequestClientSummary(WidgetRef ref, LogRequest logRequest) {
  final provider = ref.watch(clientManagerProvider).provideRequesterClient;
  final client = ref.watch(provider(logRequest.clientUid)).valueOrNull;
  if (client == null) {
    return null;
  }
  return '${client.clientId}的${client.appName}';
}
