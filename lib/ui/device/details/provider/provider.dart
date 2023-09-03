import 'package:dartx/dartx.dart';
import 'package:requester/common/device/device.dart';
import 'package:requester/common/progress/progress.dart';
import 'package:requester/domain/monitor/provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@Riverpod(dependencies: [])
String deviceHostPort(DeviceHostPortRef ref) {
  throw UnimplementedError();
}

/// 设备客户端，用来操控设备
@Riverpod(dependencies: [deviceHostPort])
Future<RequesterDeviceClient> deviceClient(DeviceClientRef ref) async {
  final hostPort = ref.watch(deviceHostPortProvider);
  final [host, port] = hostPort.split(':');
  final client = RequesterDeviceClient(host: host, port: port.toInt());
  ref.onDispose(() async {
    await client.dispose();
  });
  await client.start();
  return client;
}

@Riverpod(dependencies: [deviceClient])
Future<RequesterDeviceInfoResponse> loadDeviceInfo(
    LoadDeviceInfoRef ref) async {
  final client = await ref.watch(deviceClientProvider.future);
  return client.client!.getInfo(RequesterDeviceInfoRequest());
}

@Riverpod(dependencies: [deviceClient])
Future<String> loadDeviceLogHostPort(LoadDeviceLogHostPortRef ref) async {
  final client = await ref.watch(deviceClientProvider.future);
  return (await client.client!.getLogHostPort(Empty())).hostPort;
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
