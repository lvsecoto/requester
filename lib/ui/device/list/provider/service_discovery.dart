import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nsd/nsd.dart';
import 'package:requester/common/device/device.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
      if (!_isAppForeground(previous) && _isAppForeground(next)) {
        notifier.onStart();
      } else if (_isAppForeground(previous) && !_isAppForeground(next)) {
        notifier.onDispose();
      }
    });
    return child;
  }

  bool _isAppForeground(AppLifecycleState? appState) {
    return [AppLifecycleState.inactive, AppLifecycleState.resumed]
        .contains(appState);
  }
}

/// 当前发现的设备
@riverpod
class FoundServices extends _$FoundServices {
  late final RequesterDeviceDiscoveryService _discovery =
      RequesterDeviceDiscoveryService(_onServicesUpdate);

  /// 设备迎新回调
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
