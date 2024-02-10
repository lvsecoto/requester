import 'package:requester_common/requester_common.dart';
import 'package:requester_client/requester_client.dart';

class LogProvider {
  static const _kLogHostPort = 'log_host_port';

  HostPort? _hostPort;

  /// 设置日志要发送的地址
  Future<void> setLogHostPort(HostPort hostPort) async {
    await saveObject(_kLogHostPort, hostPort, encode: (it) => it.encode());
    _hostPort = hostPort;
  }

  /// 获取日志要发送的地址
  Future<HostPort> getLogHostPort() async {
    const defaultValue = HostPort(host: '127.0.0.1', port: 0);
    return _hostPort ??= await getObject<HostPort>(
      _kLogHostPort,
      decode: (it) {
        return HostPort.tryDecode(it) ?? defaultValue;
      },
      encode: (it) {
        return it.encode();
      },
      defaultValue: defaultValue,
    );
  }
}

