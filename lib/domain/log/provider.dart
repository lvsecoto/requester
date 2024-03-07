part of 'log.dart';

/// 日志列表Provider，观察可获取一个可以分页加载，并且响应日志增加删除事件的日志列表
///
/// 当调用:
/// * [Log.insertLog]
/// * [LogManager.deleteLog]
///
/// 这个列表会响应变化，并且不会改变分页加载状态
///
/// 提供以下分页加载操作：
/// * [LogList.refresh]
/// * [LogList.loadMore]
@riverpod
class LogList extends _$LogList with PagingLoadNotifierMixin<Log, int> {
  @override
  PagingLoadState<Log> build(LogFilter filter) {
    ref.listen(_onLogAddProvider, (_, newLog) {
      if (newLog != null && filter.isMatched(newLog)) {
        state = state.copyWith(
          data: [
            newLog,
            ...state.data,
          ],
        );
      }
    });
    ref.listen(_onLogResponseUpdateProvider, (_, updatedLogResponse) {
      if (updatedLogResponse != null) {
        final data = state.data;
        final (id, requestOverridden, response) = updatedLogResponse;
        final index = data.indexWhere((it) => it.id == id);
        if (index != -1) {
          state = state.copyWith(
            data: [
              ...data,
            ]..[index] = (data[index] as LogRequest).copyWith(
              requestOverridden: requestOverridden,
              requestResponse: response,
            ),
          );
        }
      }
    });
    ref.listen(_onLogDeleteProvider, (_, deletedLog) {
      if (deletedLog != null) {
        state = state.copyWith(
          data: [
            ...state.data,
          ]..removeWhere((it) => it.id == deletedLog.id),
        );
      }
    });
    ref.listen(_onClearLogsProvider, (_, deletedLog) {
      if (deletedLog != null) {
        state = state.copyWith(
          data: const [],
          hasMore: false,
        );
      }
    });
    ref.keepAlive();
    return onBuild(defaultData: filter.byData);
  }

  @override
  Future<LogPagingData> fetch(int? nextPageArg) async {
    final dataAfterId = nextPageArg ?? -1;
    if (dataAfterId != -1) {
      // 加载下一页的的时候，我们都放慢点速度
      await Future.delayed(const Duration(milliseconds: 300));
    }
    return ref.watch(logManagerProvider)._getLogs(
          filter: filter,
          dataAfterId: dataAfterId,
        );
  }
}

@riverpod
class _OnLogAdd extends _$OnLogAdd with SelectableNotifier {
  @override
  Log? build() {
    return null;
  }
}

@riverpod
class _OnLogResponseUpdate extends _$OnLogResponseUpdate with SelectableNotifier {
  @override
  (int, OverrideRequest?, LogResponse)? build() {
    return null;
  }
}

@riverpod
class _OnLogDelete extends _$OnLogDelete with SelectableNotifier {
  @override
  Log? build() {
    return null;
  }
}

@riverpod
class _OnClearLogs extends _$OnClearLogs with SelectableNotifier {
  @override
  Object? build() {
    return null;
  }
}

/// 加载日志为[logId]的日志
@riverpod
Future<Log> loadLog(LoadLogRef ref, int logId) async {
  final log = await ref.watch(logManagerProvider)._getLog(logId);
  ref.listen(_onLogResponseUpdateProvider, (_, next) {
    if (next != null) {
      final (id, _, __) = next;
      if (id == log.id) {
        ref.invalidateSelf();
      }
    }
  });
  return log;
}
