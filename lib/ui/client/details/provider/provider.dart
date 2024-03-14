import 'dart:typed_data';

import 'package:common/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:requester/domain/log/log.dart';
import 'package:requester/service/service.dart';
import 'package:requester_client/requester_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:requester_client/rpc.dart' as rpc;

part 'provider.g.dart';

/// 输入连接的Requester Client服务
@Riverpod(dependencies: [])
RequesterClientService? clientService(ClientServiceRef ref) {
  throw UnimplementedError();
}

/// 手动刷新
void actionRefresh(WidgetRef ref) {
  ref.invalidate(observeClientInfoProvider);
  ref.invalidate(loadClientIdProvider);
  ref.invalidate(loadClientLogHostPortProvider);
  ref.invalidate(loadIsClientLogToSelfProvider);
}

RequesterClientService _watchClient(AutoDisposeRef ref) {
  return ref.watch(clientServiceProvider)!;
}

RequesterClientService _readClient(WidgetRef ref) {
  return ref.read(clientServiceProvider)!;
}

/// 加载客户端Id
@Riverpod(dependencies: [clientService])
Future<String> loadClientId(LoadClientIdRef ref) async {
  final client = _watchClient(ref);
  return (await client.getClientId(rpc.Empty())).id;
}

/// 更新客户端id
Future<void> actionUpdateClientId(
  WidgetRef ref, {
  required String clientId,
}) async {
  final client = ref.read(clientServiceProvider)!;
  await client.setClientId(rpc.ClientId(id: clientId));
  ref.invalidate(loadClientIdProvider);
}

/// 观察Requester客户端信息
@Riverpod(dependencies: [clientService])
Stream<Map<String, String>> observeClientInfo(ObserveClientInfoRef ref) async* {
  final client = ref.watch(clientServiceProvider);
  if (client == null) yield* Stream.value({});
  yield* client!.observeClientInfo(rpc.Empty()).map(
        (it) => it.meta.map(
          (key, value) => MapEntry(
            key,
            value.value,
          ),
        ),
      );
}

/// 更新设备信息
void actionUpdateClientInfoEntry(
  WidgetRef ref, {
  required String key,
  required String value,
}) {
  ref.read(clientServiceProvider)?.updateClientInfo(
        rpc.ClientInfoEntry(key: key, value: rpc.ClientMetaValue(value: value)),
      );
}

/// 识别设备
void actionIdentityClient(WidgetRef ref) {
  ref.read(clientServiceProvider)?.identify(rpc.Empty());
}

/// 获取客户端日志要发送的地址
@Riverpod(dependencies: [clientService])
Future<HostPort> loadClientLogHostPort(LoadClientLogHostPortRef ref) async {
  final manager = ref.watch(logManagerProvider);
  return manager.getClientLogToHostPort(_watchClient(ref));
}

/// 获取客户端日志要发送的地址
@Riverpod(dependencies: [clientService])
Future<bool> loadIsClientLogToSelf(LoadIsClientLogToSelfRef ref) async {
  final manager = ref.watch(logManagerProvider);
  final hostPort = await ref.watch(loadClientLogHostPortProvider.future);
  return manager.isClientLogToSelf(hostPort);
}

/// 绑定客户端日志发送的地址到本设备
Future<void> actionBindClientLogHostPortToSelf(WidgetRef ref) async {
  final manager = ref.watch(logManagerProvider);
  await manager.bindClientLogHostPortToSelf(_readClient(ref));
  ref.invalidate(loadClientLogHostPortProvider);
}

@Riverpod(dependencies: [clientService])
class _DisplayPerformance extends _$DisplayPerformance
    with StreamValueNotifier {
  @override
  (DateTime, rpc.DisplayPerformance)? build() {
    return onBuild();
  }

  @override
  Stream<(DateTime, rpc.DisplayPerformance)> buildStream() {
    return _watchClient(ref)
        .observeDisplayPerformance(rpc.Empty())
        .map((performance) => (DateTime.now(), performance));
  }
}

/// 观察帧率
(DateTime, double) watchDisplayPerformanceFps(WidgetRef ref) {
  return ref.watch(
    _displayPerformanceProvider.select((it) {
      if (it == null) {
        return (DateTime.now(), 0.0);
      }
      return (it.$1, it.$2.fps);
    }),
  );
}

/// 观察帧率
ProviderListenable<(DateTime, double)> provideDisplayPerformanceFps(WidgetRef ref) {
  return _displayPerformanceProvider.select((it) {
    if (it == null) {
      return (DateTime.now(), 0.0);
    }
    return (it.$1, it.$2.fps);
  });
}

@Riverpod(dependencies: [clientService])
class _AppState extends _$AppState
    with StreamValueNotifier {
  @override
  AppState? build() {
    return onBuild();
  }

  @override
  Stream<AppState> buildStream() {
    return _watchClient(ref)
        .observeAppState(rpc.Empty())
        .map((it) => AppState.fromRpc(it.appState));
  }
}

AppState? watchAppState(WidgetRef ref) {
  return ref.watch(_appStateProvider);
}

/// 对设备进行截屏
Future<Uint8List> actionTakeScreenshot(WidgetRef ref) async {
  final data = await _readClient(ref).takeScreenshot(rpc.Empty());
  return Uint8List.fromList(data.picture);
}
