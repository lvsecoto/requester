import 'package:dartx/dartx.dart';
import 'package:requester/common/device/device.dart';
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
Future<RequesterDeviceInfoResponse> loadDeviceInfo(LoadDeviceInfoRef ref) async {
  final client = await ref.watch(deviceClientProvider.future);
  return client.client!.getInfo(RequesterDeviceInfoRequest());
}
