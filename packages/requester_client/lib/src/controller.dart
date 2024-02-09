import 'package:network_info_plus/network_info_plus.dart';
import 'package:nsd/nsd.dart' as nsd;
import 'package:flutter/foundation.dart';
import 'package:requester_client/requester_client.dart';
import 'package:requester_client/src/service.dart';
import 'package:requester_common/requester_common.dart';
import 'package:grpc/grpc.dart' as grpc;

class RequesterClientController extends ChangeNotifier
    implements AppLifecycleAware {
  RequesterClientController({
    required this.port,
    required this.clientInfoProvider,
  });

  /// 客户端和Requester连接的端口
  final int port;

  final ClientInfoProvider clientInfoProvider;

  /// rpc服务
  grpc.Server? _rpcServer;

  /// nsd服务注册
  nsd.Registration? _nsdRegistration;

  @override
  Future<void> onAppResume() async {
    final info = NetworkInfo();

    // nsd
    _nsdRegistration = await nsd.register(RequesterClient(
      hostPort: HostPort(
        host: await info.getWifiIP() ?? '',
        port: port,
      ),
    ).toNsdService());

    // rpc服务
    _rpcServer = grpc.Server.create(services: [
      RequesterClientService(clientInfoProvider: clientInfoProvider),
    ]);
    _rpcServer!.serve(
      port: port,
    );
  }

  @override
  Future<void> onAppPause() async {
    await _dispose();
  }


  @override
  void dispose() {
    super.dispose();
    _dispose();
  }

  Future<void> _dispose() async {
    final registration = _nsdRegistration;
    if (registration != null) {
      nsd.unregister(registration);
    }
    await _rpcServer?.shutdown();
  }
}
