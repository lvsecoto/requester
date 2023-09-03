import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:requester/common/device/device.dart';
import 'package:requester/common/progress/progress.dart';
import 'package:requester/domain/monitor/provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'provider.dart';

part 'log.g.dart';

/// 加载设备日志发送地址配置
@Riverpod(dependencies: [deviceClient])
Future<String> loadDeviceLogHostPort(LoadDeviceLogHostPortRef ref) async {
  final client = await ref.watch(deviceClientProvider.future);
  return (await client.client!.getLogHostPort(Empty())).hostPort;
}

/// 日志是否已经绑定到本设备
bool isDeviceLogBound(WidgetRef ref) {
  final deviceHostPort = ref.watch(loadDeviceLogHostPortProvider).valueOrNull;
  final monitorHostPort = ref.watch(monitorHostPortProvider).valueOrNull;
  return deviceHostPort == monitorHostPort;
}

/// 设置设备Log Host到本设备
@Riverpod(dependencies: [deviceClient])
class ActionSetDeviceHostPortToSelf extends _$ActionSetDeviceHostPortToSelf
    with ProgressingAction<Future<RequesterDeviceClient>> {
  @override
  Progress build() {
    return onBuild(ref.watch(deviceClientProvider.future));
  }

  @override
  Future run(Future<RequesterDeviceClient> input) async {
    final client = (await input).client!;
    await client.setLogHostPort(RequesterDeviceLogHostPort(
      hostPort: await ref.read(monitorHostPortProvider.future),
    ));
    return await ref.refresh(loadDeviceLogHostPortProvider.future);
  }
}

/// 重置设备Log Host，设置为空
@Riverpod(dependencies: [deviceClient])
class ActionResetDeviceHostPortToSelf extends _$ActionResetDeviceHostPortToSelf
    with ProgressingAction<Future<RequesterDeviceClient>> {
  @override
  Progress build() {
    return onBuild(ref.watch(deviceClientProvider.future));
  }

  @override
  Future run(Future<RequesterDeviceClient> input) async {
    final client = (await input).client!;
    await client.setLogHostPort(RequesterDeviceLogHostPort(
      hostPort: '',
    ));
    return await ref.refresh(loadDeviceLogHostPortProvider.future);
  }
}
