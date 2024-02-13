part of 'log.dart';

mixin _LogRecord on _LogManager {
  /// 接收到请求日志时的回调
  Future<void> onReceiveLogRequest(rpc.LogRequest logRequest) async {
    final id = await _logTable.insertOne(
      LogTableCompanion.insert(
        time: Value(DateTime.fromMillisecondsSinceEpoch(logRequest.time.toInt())),
        requestId: Value(logRequest.id),
        requestMethod: Value(logRequest.method),
        requestPath: Value(logRequest.path),
        requestHeaders: Value(logRequest.headers),
        requestQueries: Value(logRequest.queries),
        requestBody: Value(logRequest.body),
      ),
    );
    _ref.read(_onLogAddProvider.notifier).select(LogRequest(
          id: id,
          time: DateTime.fromMillisecondsSinceEpoch(logRequest.time.toInt()),
          requestId: logRequest.id,
          requestPath: logRequest.path,
          requestMethod: logRequest.method,
          requestQueries: logRequest.queries,
          requestHeaders: logRequest.headers,
          requestBody: logRequest.body,
        ));
  }

  Future<void> onReceiveLogResponse(rpc.LogResponse logResponse) async {
    await (_logTable.update()
          ..where((tbl) => tbl.requestId.equals(logResponse.id)))
        .write(LogTableCompanion(
      responseCode: Value(logResponse.code),
      responseSpentTime: Value(Duration(milliseconds: logResponse.spentTime)),
      responseError: Value(logResponse.error),
      responseBody: Value(logResponse.body),
    ));

    _ref.read(_onLogResponseUpdateProvider.notifier).select((
      logResponse.id,
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

  /// 日志列表
  late final providerLogList = logListProvider;

  /// 获取缓存的Log
  Future<LogPagingData> _getLogs({
    required int dataAfterId,
    int pageSize = 10,
  }) async {
    var data = await (_logTable.selectOnly()
          ..addColumns(_logTable.$columns)
          ..orderBy([OrderingTerm.desc(_logTable.id)])
          ..where(dataAfterId == -1
              ? const Constant(true)
              : _logTable.id.isSmallerThanValue(dataAfterId))
          ..limit(pageSize + 1))
        .map((record) {
      return _mapToLogRequest(record);
    }).get();

    final hasMore = data.length > pageSize;

    data = data.takeFirst(pageSize);

    return LogPagingData(
      data: data,
      hasMore: hasMore,
      dataAfterId: data.last.id,
    );
  }

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
    return LogRequest(
      id: record.read(_logTable.id)!,
      time: record.readWithConverter(_logTable.time)!,
      requestId: record.read(_logTable.requestId)!,
      requestPath: record.read(_logTable.requestPath)!,
      requestMethod: record.read(_logTable.requestMethod)!,
      requestQueries: record.readWithConverter(_logTable.requestQueries)!,
      requestHeaders: record.readWithConverter(_logTable.requestHeaders)!,
      requestBody: record.read(_logTable.requestBody)!,
      requestResponse: response,
    );
  }
}
