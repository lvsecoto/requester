import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:requester/client/client.dart';
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
