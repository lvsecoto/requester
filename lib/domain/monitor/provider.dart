import 'package:common/common.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:requester/domain/log/log.dart';
import 'package:requester/domain/persistence/persistence.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'monitor.dart';
import 'utils.dart';

part 'provider.g.dart';

/// 监视器端口
@riverpod
class MonitorPort extends _$MonitorPort with StreamValueNotifier<int> {
  @override
  int? build() {
    return super.build();
  }

  @override
  Stream<int> buildStream() {
    return ref.watch(appPersistenceProvider).observeMonitorPort();
  }

  /// 设置的端口
  set port(int port) {
    ref.read(appPersistenceProvider).setMonitorPort(port);
  }
}

@riverpod
class MonitorRequestList extends _$MonitorRequestList {
  var _cache = <MonitorLog>[];

  @override
  FutureOr<List<MonitorLog>> build() async {
    ref.keepAlive();
    return _cache;
  }

  @override
  set state(AsyncValue<List<MonitorLog>> newState) {
    if (newState.hasValue) {
      _cache = newState.requireValue;
    }
    super.state = newState;
  }

  /// 收到一个新的日志
  void onReceivedNew(Log log) {
    final element = log.element;
    switch (element) {
      /// 请求日志
      case LogRequest():

        /// 创建一个请求记录
        state = AsyncData([
          MonitorLogRequest(id: log.id, logRequest: element, time: DateTime.now()),
          ..._cache,
        ]);
        break;

      /// 响应日志
      case LogResponse():

        /// 找到对应的请求日志，把响应记录填充进去
        state = AsyncData(_cache.update(
          (it) => (it as MonitorLogRequest).id == log.id,
          (it) => (it as MonitorLogRequest).copyWith(
            logResponse: element,
          ),
        ));
        break;
      case LogException():

        /// 找到对应的请求日志，把响应记录填充进去
        state = AsyncData(_cache.update(
          (it) => (it as MonitorLogRequest).id == log.id,
          (it) => (it as MonitorLogRequest).copyWith(
            logException: element,
          ),
        ));
        break;
    }
  }

  /// 添加一个分割线
  void addDivider() {
    final list = state.value;
    if (list != null) {
      state = AsyncData([
        MonitorLogDivider(color: Colors.grey, time: DateTime.now()),
        ...list,
      ]);
    }
  }

  /// 清除所有记录
  void clean() {
    state = const AsyncData([]);
  }
}

const kLatestRequestId = 'latest';

@riverpod
Future<MonitorLogRequest> getMonitorRequest(
    GetMonitorRequestRef ref, String requestId) async {
  MonitorLogRequest request;
  if (requestId == kLatestRequestId) {
    request = ref.watch(monitorRequestListProvider.select(
      (it) => it.requireValue.firstOrNullWhere((it) => it is MonitorLogRequest),
    )) as MonitorLogRequest;
  } else {
    request = ref.watch(monitorRequestListProvider.select(
      (it) => it.requireValue.firstWhere(
        (it) => (it is MonitorLogRequest) && it.id == requestId,
      ),
    )) as MonitorLogRequest;
  }
  return request;
}
