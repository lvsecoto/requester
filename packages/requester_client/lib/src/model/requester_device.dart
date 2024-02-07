/// Requester 设备
library;

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nsd/nsd.dart' as nsd;

import 'model.dart';

part 'requester_device.freezed.dart';

/// 描述一个Requester设备
@freezed
class RequesterClient with _$RequesterClient {
  const RequesterClient._();

  const factory RequesterClient({
    /// 设备的访问地址
    required HostPort hostPort,
  }) = _RequesterClient;

  /// 从NSD服务创建Client
  static RequesterClient fromNsdService(nsd.Service service) {
    final host = utf8.decode(service.txt?['host']?.toList() ?? []);
    final port = int.parse(utf8.decode(service.txt?['port']?.toList() ?? []));
    return RequesterClient(hostPort: HostPort(host: host, port: port));
  }

  /// 转换为服务
  nsd.Service toNsdService() {
    return nsd.Service(
      name: hostPort.host,
      port: hostPort.port,
      type: '_requester._tcp',
      txt: {
        'host': utf8.encode(hostPort.host),
        'port': utf8.encode(hostPort.port.toString()),
      }
    );
  }
}
