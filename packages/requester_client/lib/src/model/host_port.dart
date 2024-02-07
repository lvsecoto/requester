import 'package:freezed_annotation/freezed_annotation.dart';

part 'host_port.freezed.dart';

@freezed
class HostPort with _$HostPort {
  const factory HostPort({
    required String host,
    required int port,
  }) = _HostPort;
}
