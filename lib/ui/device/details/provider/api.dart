import 'package:requester/common/device/service/service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'provider.dart';

part 'api.g.dart';

/// 加载设备日志发送地址配置
@Riverpod(dependencies: [deviceClient])
Future<String> loadDeviceApiHostOverride(LoadDeviceApiHostOverrideRef ref) async {
  final client = await ref.watch(deviceClientProvider.future);
  return (await client.client!.getApiHostPortOverride(Empty())).hostPort;
}

