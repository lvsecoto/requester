part of 'log.dart';

mixin _HostPortManager on _LogManager{
  /// Requester Client日志应到发送到的端口
  final int port = 5200;

  /// 获取Requester Client日志发送到哪个HostPort
  Future<HostPort> getClientLogToHostPort(RequesterClientService client) async {
    final data = await client.getLogHostPort(rpc.Empty());
    return HostPort(
      host: data.host,
      port: data.port,
    );
  }

  Future<HostPort> _getSelfHostPort() async {
    final info = NetworkInfo();
    final ip = await info.getWifiIP();
    if (ip == null) {
      throw '未连接到Wifi';
    }
    return HostPort(
      host: ip,
      port: port,
    );
  }

  /// 判断Requester Client要发送日志的HostPort是否是指向本Requester
  Future<bool> isClientLogToSelf(HostPort clientLogToHostPort) async {
    return await _getSelfHostPort() == clientLogToHostPort;
  }

  /// 绑定Requester Client的日志上报地址到本设备
  Future<void> bindClientLogHostPortToSelf(
      RequesterClientService client) async {
    final hostPort = await _getSelfHostPort();
    await client.setLogHostPort(
      rpc.LogHostPort(
        host: hostPort.host,
        port: hostPort.port,
      ),
    );
  }
}
