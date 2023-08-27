import 'package:nsd/nsd.dart';
import 'package:synchronized/synchronized.dart';

class RequesterDeviceDiscoveryService {
  /// 负责设备发现，利用Bonjour
  RequesterDeviceDiscoveryService(this.onServiceUpdate);

  Discovery? _discovery;

  final _lock = Lock();

  /// 服务更新回调
  final Function(List<Service> service) onServiceUpdate;

  /// 启动发现服务，启动-停止可重复
  Future<void> start() => _lock.synchronized(() async {
    if (_discovery != null) {
      await stopDiscovery(_discovery!);
    }
    _discovery = await startDiscovery('_http._tcp')
      ..addListener(() {
        onServiceUpdate(_discovery!.services);
      });
  });

  /// 停止发现服务，启动-停止可重复
  Future<void> dispose() => _lock.synchronized(() async {
    await stopDiscovery(_discovery!);
    _discovery = null;
  });
}
