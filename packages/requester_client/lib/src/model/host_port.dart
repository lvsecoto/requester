import 'package:freezed_annotation/freezed_annotation.dart';

part 'host_port.freezed.dart';

@freezed
class HostPort with _$HostPort {
  /// 描述设备的地址和端口
  const factory HostPort({
    required String host,
    required int port,
  }) = _HostPort;
}
