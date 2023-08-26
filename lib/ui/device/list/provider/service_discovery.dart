import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nsd/nsd.dart' as nsd;
import 'package:nsd/nsd.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:synchronized/synchronized.dart';

part 'service_discovery.g.dart';

class ServiceDiscoveryController extends HookConsumerWidget {

  /// 提供给予App生命周期开关的设备发现组件
  const ServiceDiscoveryController({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(foundServicesProvider.notifier);
    useOnAppLifecycleStateChange((previous, next) {
      if (_isAppPause(previous) && _isAppResume(next)) {
        notifier.onStart();
      } else if (_isAppResume(previous) && _isAppPause(next)) {
        notifier.onDispose();
      }
    });
    return child;
  }

  bool _isAppResume(AppLifecycleState? appState) {
    return [AppLifecycleState.inactive, AppLifecycleState.resumed]
        .contains(appState);
  }

  bool _isAppPause(AppLifecycleState? appState) {
    return [AppLifecycleState.paused, AppLifecycleState.detached]
        .contains(appState);
  }
}

/// 当前发现的设备
@riverpod
class FoundServices extends _$FoundServices {
  late final MonitorDeviceDiscovery _discovery =
      MonitorDeviceDiscovery(_onServicesUpdate);

  void _onServicesUpdate(List<Service> services) {
    state = services;
  }

  @override
  List<Service> build() {
    _discovery.start();
    return [];
  }

  void onStart() {
    _discovery.start();
  }

  void onDispose() {
    _discovery.dispose();
  }
}

class MonitorDeviceDiscovery {
  /// 负责设备发现，利用Bonjour
  MonitorDeviceDiscovery(this.onServiceUpdate);

  nsd.Discovery? _discovery;

  final _lock = Lock();

  /// 服务更新回调
  final Function(List<Service> service) onServiceUpdate;

  Future<void> start() => _lock.synchronized(() async {
        if (_discovery != null) {
          await nsd.stopDiscovery(_discovery!);
        }
        _discovery = await startDiscovery('_http._tcp')
          ..addListener(() {
            onServiceUpdate(_discovery!.services);
          });
      });

  Future<void> dispose() => _lock.synchronized(() async {
        await stopDiscovery(_discovery!);
        _discovery = null;
      });
}
