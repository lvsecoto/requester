part of 'log.dart';

/// 指向最近更新的一个日志
const kLatestRequestId = -1;

/// 代表一个日志
@freezed
class Log with _$Log {

  /// 请求日志
  const factory Log.request({
    required int id,
    required DateTime time,

    required String requestId,
    required String requestPath,
    required String requestMethod,
    required Map<String, String> requestQueries,
    required Map<String, String> requestHeaders,
    required String requestBody,

    LogResponse? requestResponse,
  }) = LogRequest;
}

@freezed
class LogResponse with _$LogResponse {
  const factory LogResponse({
    required int code,
    required String body,
    required String error,

    /// 响应时间
    required Duration spentTime,
  }) = _LogResponse;
}

class LogPagingData implements PagingData<int, Log> {
  /// 日志分页数据
  ///
  LogPagingData({
    required this.data,
    required this.hasMore,
    required this.dataAfterId,
  });

  /// limit: pageSize + 1 拿多一条判断是否有更多数据
  ///
  /// 然后
  /// data = data.takeFirst(pageSize);
  @override
  final List<Log> data;

  /// data.length > pageSize
  @override
  final bool hasMore;

  @override
  int get nextPageArg => dataAfterId;

  /// 利用id进行分页，
  /// where: dataAfterId == -1
  /// ? const Constant(true)
  /// : _table.id.isSmallerThanValue(dataAfterId)
  final int dataAfterId;
}
