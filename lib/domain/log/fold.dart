part of 'log.dart';

/// 这里处理日志折叠
// 优先先判断当前正在匹配的条件，如果当前的不匹配，就不折叠
// 如
// log1 -> test1 -> matchedTest = t1
// log2 -> test1 -> matchedTest匹配
// log3 -> test1 -> matchedTest匹配
// log4 -> x -> 折叠
// 再如
// log1 -> test1 -> matchedTest = t1
// log2 -> test2 -> matchedTest不匹配, matchedTest = t2
// ...
extension FoldLog on List<Log> {

  /// 已折叠的日志合并另一个已经折叠的日志
  List<Log> joinNextFoldLog(List<Log> nextLog, Set<FoldLogCondition> tests) {
    final toFoldLog = <Log>[];
    final prevLogLast = lastOrNull;
    final nextLogFirst = nextLog.firstOrNull;

    List<Log> toAddPrevLog;
    List<Log> toAddNextLog;

    if (prevLogLast is FoldedLogs) {
      toFoldLog.addAll(prevLogLast.logs);
      toAddPrevLog = dropLast(1);
    } else {
      toFoldLog.addAll(takeLast(3));
      toAddPrevLog = dropLast(3);
    }

    if (nextLogFirst is FoldedLogs) {
      toFoldLog.addAll(nextLogFirst.logs);
      toAddNextLog = nextLog.drop(1);
    } else {
      toFoldLog.addAll(nextLog.take(3));
      toAddNextLog = nextLog.drop(3);
    }

    final foldLogs = toFoldLog.foldLogs(tests);
    final logs = [
      ...toAddPrevLog,
      ...foldLogs,
      ...toAddNextLog,
    ];
    return logs;
  }

  /// 按折叠规则[tests]，折叠日志
  List<Log> foldLogs(Set<FoldLogCondition> tests) {
    final logs = <Log>[];
    final toFoldLogs = <Log>[];
    FoldLogCondition? matchedTest;

    void finishFoldLog() {
      if (toFoldLogs.length > 2) {
        // appState日志超过了三条，折叠
        logs.add(Log.foldedLogs(
          id: toFoldLogs.last.id,
          logs: [...toFoldLogs],
          condition: matchedTest!,
        ));
      } else {
        // 不折叠，按回原来一条一条放入
        logs.addAll(toFoldLogs);
      }
      toFoldLogs.clear();
    }

    bool captureToFoldLog(Log log, Set<FoldLogCondition> tests) {
      var hasCaptured = false;
      if (matchedTest != null) {
        if (matchedTest!(log)) {
          toFoldLogs.add(log);
          hasCaptured = true;
        } else {
          finishFoldLog();
          matchedTest = null;
        }
      } else {
        matchedTest = tests.firstOrNullWhere((it) => it(log));

        if (matchedTest != null) {
          toFoldLogs.add(log);
          hasCaptured = true;
        }
      }
      return hasCaptured;
    }

    for (var log in this) {
      final hasCaptured = captureToFoldLog(log, tests);
      if (!hasCaptured) {
        logs.add(log);
      }
    }
    finishFoldLog();
    matchedTest = null;

    return logs;
  }
}
