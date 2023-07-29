import 'package:requester/domain/log/log.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'monitor.dart';
import 'utils.dart';

part 'provider.g.dart';

@riverpod
class MonitorRequestList extends _$MonitorRequestList {
  var _cache = <MonitorRequest>[];

  @override
  FutureOr<List<MonitorRequest>> build() async {
    return [];
  }

  /// 收到一个新的日志
  void onReceivedNew(Log log) {
    final element = log.element;
    switch (element) {
      /// 请求日志
      case LogRequest():

        /// 创建一个请求记录
        _cache = [
          MonitorRequest(id: log.id, logRequest: element),
          ..._cache,
        ];
        state = AsyncData(_cache);
        break;

      /// 响应日志
      case LogResponse():
        /// 找到对应的请求日志，把响应记录填充进去
        _cache = _cache.update(
          (it) => it.id == log.id,
          (it) => it.copyWith(
            logResponse: element,
          ),
        );
        state = AsyncData(_cache);
        break;
      case LogException():
      /// 找到对应的请求日志，把响应记录填充进去
        _cache = _cache.update(
              (it) => it.id == log.id,
              (it) => it.copyWith(
            logException: element,
          ),
        );
        state = AsyncData(_cache);
        break;
    }
  }
}
