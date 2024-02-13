part of 'log.dart';

typedef LogListProvider = AutoDisposeNotifierProvider<LogList, PagingLoadState<Log>>;

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
  PagingLoadState<Log> build() {
    ref.listen(_onLogAddProvider, (_, newLog) {
      if (newLog != null) {
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
        final (requestId, response) = updatedLogResponse;
        final index = data.indexWhere((it) => it.requestId == requestId);
        if (index != -1) {
          state = state.copyWith(
            data: [
              ...data,
            ]..[index] = data[index].copyWith(
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
    ref.keepAlive();
    return onBuild();
  }

  @override
  Future<LogPagingData> fetch(int? nextPageArg) async {
    final dataAfterId = nextPageArg ?? -1;
    if (dataAfterId != -1) {
      // 加载下一页的的时候，我们都放慢点速度
      await Future.delayed(const Duration(milliseconds: 300));
    }
    return ref.watch(logManagerProvider)._getLogs(
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
  (String, LogResponse)? build() {
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

/// 加载日志为[logId]的日志
@riverpod
Future<Log> loadLog(LoadLogRef ref, int logId) async {
  return await ref.watch(logManagerProvider)._getLog(logId);
}
