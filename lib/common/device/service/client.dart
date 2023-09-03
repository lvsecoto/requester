import 'package:requester/common/device/service/requester_device.pbgrpc.dart';
import 'package:grpc/grpc.dart';
import 'package:synchronized/synchronized.dart';

class RequesterDeviceClient {
  RequesterDeviceClient({
    required this.host,
    required this.port,
  });

  /// 连接设备主机地址
  final String host;

  /// 连接设备端口
  final int port;

  /// 通过[client]获取设备服务
  RequesterDeviceServiceClient? client;
  ClientChannel? _channel;
  final _lock = Lock();

  /// 启动服务
  Future<void> start() async => _lock.synchronized(() async {
    if (_channel != null) {
      await _channel!.shutdown();
    }
    _channel = ClientChannel(
      host,
      port: port,
      options: ChannelOptions(
        credentials: const ChannelCredentials.insecure(),
        codecRegistry:
        CodecRegistry(codecs: const [GzipCodec(), IdentityCodec()]),
      ),
    );
    client = RequesterDeviceServiceClient(_channel!);
  });

  /// 关闭服务
  Future<void> dispose() => _lock.synchronized(() async {
    if (_channel != null) {
      await _channel!.shutdown();
    }
  });
}
