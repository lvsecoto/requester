import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:requester/domain/log/log.dart';

part 'model.freezed.dart';

@freezed
class MonitorRequest with _$MonitorRequest {
  const factory MonitorRequest({
    required String id,
    /// 请求日志
    required LogRequest logRequest,
    /// 响应日志，可能为空，因为正在请求中
    LogResponse? logResponse,
}) = _MonitorRequest;
}
