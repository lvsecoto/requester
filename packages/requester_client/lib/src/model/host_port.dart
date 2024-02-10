import 'package:freezed_annotation/freezed_annotation.dart';

part 'host_port.freezed.dart';

@freezed
class HostPort with _$HostPort {

  const HostPort._();

  /// 描述设备的地址和端口
  const factory HostPort({
    required String host,
    required int port,
  }) = _HostPort;

  static HostPort decode(String string) {
    final segments = string.split(':');
    assert(segments.length == 2);
    return HostPort(
      host: segments.first,
      port: int.parse(segments.last),
    );
  }

  static HostPort? tryDecode(String string) {
    try {
      return decode(string);
    } catch (_) {
      return null;
    }
  }

  String encode() {
    return '$host:$port';
  }
}
