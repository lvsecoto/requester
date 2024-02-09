/// Requester 设备
library;

import 'dart:convert';
import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nsd/nsd.dart' as nsd;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:requester_common/requester_common.dart';

import 'model.dart';

part 'requester_device.freezed.dart';

/// 描述一个Requester设备
@freezed
class RequesterClient with _$RequesterClient {
  const RequesterClient._();

  const factory RequesterClient({
    required String appName,
    required String appVersion,
    required String clientId,

    /// 设备的访问地址
    required HostPort hostPort,
  }) = _RequesterClient;

  static const _kClientId = 'client_id';

  static Future<RequesterClient> create(HostPort hostPort) async {
    final info = await PackageInfo.fromPlatform();
    return RequesterClient(
      appName: info.appName,
      appVersion: '${info.version}+${info.buildNumber}',
      clientId: await getClientId(),
      hostPort: hostPort,
    );
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
        'app_name': utf8.encode(appName),
        'app_version': utf8.encode(appVersion),
        'client_id': utf8.encode(clientId),
      },
    );
  }

  /// 从NSD服务创建Client
  static RequesterClient fromNsdService(nsd.Service service) {
    return RequesterClient(
      appName: _decode(service, 'app_name'),
      appVersion: _decode(service, 'app_version'),
      clientId: _decode(service, 'client_id'),
      hostPort: HostPort(
        host: _decode(service, 'host'),
        port: int.parse(_decode(service, 'port')),
      ),
    );
  }

  static String _decode(nsd.Service service, String key) {
    return utf8.decode(service.txt?[key]?.toList() ?? []);
  }

  /// 设置客户端Id
  static Future<void> setClientId(String id) async {
    await saveObject(_kClientId, id, encode: (it) => it);
  }

  /// 获取客户端Id
  static Future<String> getClientId() async {
    return await getObject(
      _kClientId,
      decode: (input) => input,
      encode: (input) => input,
      defaultValue: _getRandomString(6),
    );
  }
}

String _getRandomString(int length) {
  const chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final rnd = Random();
  return String.fromCharCodes(Iterable.generate(
      length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
}
