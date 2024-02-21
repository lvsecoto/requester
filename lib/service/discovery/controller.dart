part of 'discovery.dart';

/// [RequesterClient]客户端发现控制器
class RequesterClientDiscoveryController extends ChangeNotifier
    implements AppLifecycleAware {
  static RequesterClientDiscoveryController of(BuildContext context) {
    return _ClientDiscoveryControllerHolder._of(context).controller;
  }

  nsd.Discovery? _nsdDiscovery;

  /// 当前已有设备
  List<RequesterClient> get clients => _clients;
  List<RequesterClient> _clients = [];

  /// 释放时，停止发现
  @override
  void dispose() {
    super.dispose();
    _stop();
  }

  /// 启动发现服务
  Future<void> _start() async {
    _nsdDiscovery = await nsd.startDiscovery('_requester._tcp', ipLookupType: nsd.IpLookupType.any)
      ..addListener(() {
        final services = _nsdDiscovery?.services ?? [];
        _clients = services
            .map((service) => RequesterClient.fromNsdService(service))
            .toList();
        notifyListeners();
      });
  }

  /// 停止发现服务，启动-停止可重复
  Future<void> _stop() async {
    if (_nsdDiscovery == null) return;
    await nsd.stopDiscovery(_nsdDiscovery!);
    _nsdDiscovery = null;
  }

  @override
  Future<void> onAppResume() async {
    await _start();
  }

  @override
  Future<void> onAppPause() async {
    await _stop();
  }
}
