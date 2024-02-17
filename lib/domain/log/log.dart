import 'package:common/common.dart';
import 'package:dartx/dartx.dart';
import 'package:drift/drift.dart' hide JsonKey;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:requester/client/client.dart';
import 'package:requester/data/db/db.dart';
import 'package:requester_client/requester_client.dart';
import 'package:requester_client/rpc.dart' as rpc;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'log.freezed.dart';

part 'model.dart';

part 'host_port.dart';

part 'record.dart';

part 'provider.dart';

part 'log.g.dart';

@riverpod
LogManager logManager(LogManagerRef ref) {
  return LogManager(ref);
}

abstract class _LogManager {
  AutoDisposeRef get _ref;

  $LogTableTable get _logTable;
}

class LogManager extends _LogManager with _HostPortManager, _LogRecord {
  LogManager(this._ref);

  @override
  late final _logTable = _ref.watch(appDataBaseProvider).logTable;

  @override
  final AutoDisposeRef _ref;

  Future<Log> _getLog(int logId) {
    return (_logTable.selectOnly()
          ..addColumns(_logTable.$columns)
          ..where(_logTable.id.equals(logId)))
        .map(_mapToLogRequest)
        .getSingle();
  }

  /// 加载日志
  late final provideLoadLog = loadLogProvider;

  /// 清除日志
  Future<void> clear() async {
    await _logTable.deleteAll();
    _ref.read(_onClearLogsProvider.notifier).select(DateTime.now());
  }
}
