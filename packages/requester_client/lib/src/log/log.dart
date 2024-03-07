import 'package:requester_client/rpc.dart' as rpc;
import 'package:requester_common/requester_common.dart';
import 'package:requester_client/requester_client.dart';
import 'package:grpc/grpc.dart' as grpc;
import 'package:uuid/v1.dart';

class LogProvider implements AppLifecycleAware {
  static const _kLogHostPort = 'log_host_port';

  HostPort? _hostPort;

  /// 生成基础日志信息
  Future<rpc.Log> createLog({String? id}) async {
    return rpc.Log(
      id: id ?? const UuidV1().generate(),
      clientUid: await RequesterClient.getClientUid(),
      time: rpc.Int64(DateTime.now().millisecondsSinceEpoch),
    );
  }

  /// 设置日志要发送的地址
  Future<void> setLogHostPort(HostPort hostPort) async {
    await saveObject(_kLogHostPort, hostPort, encode: (it) => it.encode());
    _hostPort = hostPort;
    await _start();
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

  @override
  Future<void> onAppResume() async {
    await _start();
  }

  @override
  Future<void> onAppPause() async {
    await _stop();
  }

  /// 通过[client]向Requester报告日志
  rpc.RequesterLogServiceClient? get client => _client;
  rpc.RequesterLogServiceClient? _client;

  grpc.ClientChannel? _channel;

  Future<void> _start() async {
    await _stop();
    final hostPort = await getLogHostPort();
    _channel = grpc.ClientChannel(
      hostPort.host,
      options: const grpc.ChannelOptions(
        credentials: grpc.ChannelCredentials.insecure(),
      ),
      port: hostPort.port,
    );
    _client = rpc.RequesterLogServiceClient(
      _channel!,
    );
  }

  Future<void> _stop() async {
    final channel = _channel;
    if (channel != null) {
      await channel.shutdown();
    }
    _channel = null;
    _client = null;
  }

  Future<void> restart() async {
    await _stop();
    await _start();
  }

  void dispose() {
    _stop();
  }
}
