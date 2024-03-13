import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:nsd/nsd.dart' as nsd;
import 'package:requester_client/src/identity/identity.dart';
import 'package:requester_common/requester_common.dart';
import 'package:grpc/grpc.dart' as grpc;

import 'client_info/client_info.dart';
import 'log/log.dart';
import 'model/model.dart';
import 'override/override.dart';
import 'display_performance/display_performance.dart';
import 'app_state/app_state.dart';
import 'screenshot/screenshot.dart';
import 'service.dart';

part 'widget/requester_client_widget.dart';

/// 管理Requester客户端的发现服务注册以及提供给Requester的服务
class RequesterClientController extends ChangeNotifier
    implements AppLifecycleAware {
  static RequesterClientController? of(BuildContext context) {
    return context
        .findAncestorWidgetOfExactType<_RequesterControllerHolder>()
        ?.controller;
  }

  RequesterClientController({
    required this.port,
  });

  /// 客户端和Requester连接的端口
  final int port;

  /// 用于向Requester报告设备信息
  final clientInfoProvider = ClientInfoProvider();

  /// 显示性能
  final displayPerformanceProvider = DisplayPerformanceProvider();

  /// 管理日志相关
  final logProvider = LogProvider();

  /// 管理App状态
  late final appStateProvider = AppStateProvider(logProvider);

  /// 管理重载
  final overrideProvider = OverrideProvider();

  /// 当发起识别命令
  late VoidCallback onIdentity;

  /// rpc服务
  grpc.Server? _rpcServer;

  /// nsd服务注册
  nsd.Registration? _nsdRegistration;

  @override
  Future<void> onAppResume() async {
    // nsd
    final info = NetworkInfo();
    final client = await RequesterClient.create(
      HostPort(
        host: await info.getWifiIP() ?? '',
        port: port,
      ),
    );
    _nsdRegistration = await nsd.register(client.toNsdService());

    // rpc服务
    _rpcServer = grpc.Server.create(services: [
      RequesterClientService(
        clientInfoProvider: clientInfoProvider,
        logProvider: logProvider,
        overrideProvider: overrideProvider,
        displayPerformanceProvider: displayPerformanceProvider,
        appStateProvider: appStateProvider,
        // todo, 改成provider
        onClientIdChanged: () {
          _restartNsd();
        },
        onIdentify: () {
          onIdentity();
        },
      ),
    ]);
    await _rpcServer!.serve(
      port: port,
    );
    await logProvider.onAppResume();
  }

  @override
  Future<void> onAppPause() async {
    await _disposeNsd();
    await _rpcServer?.shutdown();
    await logProvider.onAppPause();
  }

  @override
  void dispose() {
    super.dispose();
    _disposeNsd();
    _rpcServer?.shutdown();
    logProvider.dispose();
  }

  Future<void> _registerNsd() async {
    final info = NetworkInfo();
    final client = await RequesterClient.create(
      HostPort(
        host: await info.getWifiIP() ?? '',
        port: port,
      ),
    );
    _nsdRegistration = await nsd.register(client.toNsdService());
  }

  Future<void> _disposeNsd() async {
    final registration = _nsdRegistration;
    if (registration != null) {
      await nsd.unregister(registration);
    }
  }

  Future<void> _restartNsd() async {
    await _disposeNsd();
    await _registerNsd();
  }
}
