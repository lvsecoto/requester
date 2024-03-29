part of 'log.dart';

mixin _LogRecord on _LogManager {
  /// 接收到请求日志时的回调
  Future<void> onReceiveLogRequest(rpc.LogRequest logRequest) async {
    final overridden =
        OverrideRequest.tryFromJson(logRequest.requestOverridden.toJson());
    final id = await _logTable.insertOne(
      LogTableCompanion.insert(
        logId: logRequest.log.id,
        logTime:
            DateTime.fromMillisecondsSinceEpoch(logRequest.log.time.toInt()),
        logClientUid: logRequest.log.clientUid,
        requestMethod: Value(logRequest.method),
        requestPath: Value(logRequest.path),
        requestHeaders: Value(logRequest.headers),
        requestQueries: Value(logRequest.queries),
        requestBody: Value(logRequest.body),
        requestOverridden: Value(overridden),
      ),
    );
    _ref.read(_onLogAddProvider.notifier).select(LogRequest(
          id: id,
          time:
              DateTime.fromMillisecondsSinceEpoch(logRequest.log.time.toInt()),
          clientUid: logRequest.log.clientUid,
          requestPath: logRequest.path,
          requestMethod: logRequest.method,
          requestQueries: logRequest.queries,
          requestHeaders: logRequest.headers,
          requestBody: logRequest.body,
          requestOverridden: overridden,
        ));
  }

  Future<void> onReceiveLogResponse(rpc.LogResponse logResponse) async {
    final requestOverridden =
        OverrideRequest.tryFromJson(logResponse.requestOverridden.toJson());
    final log = (await (_logTable.update()
              ..where((tbl) => tbl.logId.equals(logResponse.log.id)))
            .writeReturning(LogTableCompanion(
      requestOverridden: Value(requestOverridden),
      responseCode: Value(logResponse.code),
      responseSpentTime: Value(Duration(milliseconds: logResponse.spentTime)),
      responseError: Value(logResponse.error),
      responseBody: Value(logResponse.body),
    )))
        .firstOrNull;

    if (log != null) {
      _ref.read(_onLogResponseUpdateProvider.notifier).select((
        log.id,
        requestOverridden,
        LogResponse(
          code: logResponse.code,
          body: logResponse.body,
          error: logResponse.error,
          spentTime: Duration(
            milliseconds: logResponse.spentTime,
          ),
        )
      ));
    }
  }

  /// 当接收到App状态日志时
  Future<void> onReceiveLogAppState(rpc.LogAppState logAppState) async {
    final logId = logAppState.log.id;
    final logTime =
        DateTime.fromMillisecondsSinceEpoch(logAppState.log.time.toInt());
    final logClientUid = logAppState.log.clientUid;
    final appState = AppState.fromRpc(logAppState.appState);
    final id = await _logTable.insertOne(
      LogTableCompanion.insert(
        logId: logId,
        logTime: logTime,
        logClientUid: logClientUid,
        appState: Value(
          appState,
        ),
      ),
    );
    _ref.read(_onLogAddProvider.notifier).select(
          Log.appState(
            id: id,
            time: logTime,
            clientUid: logClientUid,
            state: appState,
          ),
        );
  }

  /// 日志列表
  late final providerLogList = logListProvider;

  /// 获取缓存的Log
  Future<LogPagingData> _getLogs({
    LogFilter filter = const LogFilter(),
    required int dataAfterId,
    int pageSize = 10,
  }) async {
    Expression<bool> filterExpr;
    // 防止匹配到json字符
    var query = filter.query.replaceAll(RegExp('[",{}]'), '');
    if (query == '') {
      filterExpr = const Constant(true);
    } else {
      filterExpr = _logTable.requestPath.contains(query) |
          _logTable.requestQueries.contains(query) |
          _logTable.requestHeaders.contains(query) |
          _logTable.requestBody.contains(query) |
          _logTable.responseBody.contains(query);
    }
    var data = await (_logTable.selectOnly()
          ..addColumns(_logTable.$columns)
          ..orderBy([OrderingTerm.desc(_logTable.id)])
          ..where(filterExpr &
              (dataAfterId == -1
                  ? const Constant(true)
                  : _logTable.id.isSmallerThanValue(dataAfterId)))
          ..limit(pageSize + 1))
        .map((record) {
      return _mapToLog(record);
    }).get();

    final hasMore = data.length > pageSize;

    data = data.takeFirst(pageSize);

    return LogPagingData(
      data: data,
      hasMore: hasMore,
      dataAfterId: hasMore ? data.last.id : -2,
    );
  }

  Log _mapToLog(TypedResult record) {
    if (record.read(_logTable.appState) != null) {
      return _mapToLogAppState(record);
    } else {
      return _mapToLogRequest(record);
    }
  }

  /// 映射成请求日志
  LogRequest _mapToLogRequest(TypedResult record) {
    final responseCode = record.read(_logTable.responseCode);
    LogResponse? response;

    if (responseCode != null) {
      response = LogResponse(
        code: responseCode,
        body: record.read(_logTable.responseBody)!,
        error: record.read(_logTable.responseError)!,
        spentTime: record.readWithConverter(_logTable.responseSpentTime)!,
      );
    }
    return Log.request(
      id: record.read(_logTable.id)!,
      time: record.readWithConverter(_logTable.logTime)!,
      clientUid: record.read(_logTable.logClientUid)!,
      requestPath: record.read(_logTable.requestPath)!,
      requestMethod: record.read(_logTable.requestMethod)!,
      requestQueries: record.readWithConverter(_logTable.requestQueries)!,
      requestHeaders: record.readWithConverter(_logTable.requestHeaders)!,
      requestBody: record.read(_logTable.requestBody)!,
      requestResponse: response,
      requestOverridden: record.readWithConverter<OverrideRequest?, String>(
          _logTable.requestOverridden),
    ) as LogRequest;
  }

  /// 映射成App状态日志
  LogAppState _mapToLogAppState(TypedResult record) {
    final appState = record.readWithConverter(_logTable.appState);
    return LogAppState(
      id: record.read(_logTable.id)!,
      time: record.readWithConverter(_logTable.logTime)!,
      clientUid: record.read(_logTable.logClientUid)!,
      state: appState!,
    );
  }
}
