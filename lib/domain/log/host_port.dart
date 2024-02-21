part of 'log.dart';

mixin _HostPortManager on _LogManager{
  /// Requester 接收Client日志的端口
  final int port = 5200;

  /// 获取Requester Client日志发送到哪个HostPort
  Future<HostPort> getClientLogToHostPort(RequesterClientService client) async {
    final data = await client.getLogHostPort(rpc.Empty());
    return HostPort(
      host: data.host,
      port: data.port,
    );
  }

 /// 获取用于接收日志的地址和端口
  Future<HostPort> _getSelfHostPort() async {
    return HostPort(
      host: await getIntranetIpv4(),
      port: port,
    );
  }

  /// 判断Requester Client要发送日志的HostPort是否是指向本Requester
  Future<bool> isClientLogToSelf(HostPort clientLogToHostPort) async {
    final selfHostPort = await _getSelfHostPort();
    return selfHostPort == clientLogToHostPort;
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
