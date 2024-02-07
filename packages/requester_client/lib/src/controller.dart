import 'package:network_info_plus/network_info_plus.dart';
import 'package:nsd/nsd.dart' as nsd;
import 'package:flutter/foundation.dart';
import 'package:requester_common/requester_common.dart';
import 'package:synchronized/synchronized.dart';

import 'model/model.dart';

class RequesterClientController extends ChangeNotifier
    implements AppLifecycleAware {

  RequesterClientController({
    required this.port,
  });

  nsd.Registration? _registration;

  /// 客户端和Requester连接的端口
  final int port;

  @override
  Future<void> onAppResume() async {
    final info = NetworkInfo();
    final service = RequesterClient(
      hostPort: HostPort(
        host: await info.getWifiIP() ?? '',
        port: port,
      ),
    ).toNsdService();
    _registration = await nsd.register(service);
  }

  @override
  Future<void> onAppPause() async {
    final registration = _registration;
    if (registration != null) {
      nsd.unregister(registration);
    }
  }
}
