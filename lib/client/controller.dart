part of 'client.dart';

/// 用于访问Requester Client提供的服务
typedef RequesterClientService = rpc.RequesterClientServiceClient;

class RequesterClientServiceController extends ChangeNotifier implements AppLifecycleAware {

  /// 客户端服务控制器，输入客户端的[hostPort]，利用[clientService]和client通信
  ///
  /// 需要在Widget上和和App生命周期绑定好
  RequesterClientServiceController({
    required this.hostPort,
  });

  static RequesterClientServiceController of(BuildContext context) {
    return _ControllerHolder._of(context);
  }

  final HostPort hostPort;

  grpc.ClientChannel? _client;

  RequesterClientService? _service;
  RequesterClientService? get clientService => _service;

  @override
  Future<void> onAppResume() async {
    _client = grpc.ClientChannel(hostPort.host,
        port: hostPort.port,
        options: const grpc.ChannelOptions(
          credentials: grpc.ChannelCredentials.insecure(),
        ));
    _service = rpc.RequesterClientServiceClient(
      _client!,
    );
    notifyListeners();
  }

  @override
  Future<void> onAppPause() async {
    _client?.shutdown();
    _service = null;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _client?.shutdown();
    _service = null;
  }
}
