import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:requester_client/requester_client.dart';
import 'package:requester_client/rpc.dart' as rpc;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:requester/client/client.dart';

part 'provider.g.dart';

/// 输入连接的Requester Client服务
@Riverpod(dependencies: [])
RequesterClientService? clientService(ClientServiceRef ref) {
  throw UnimplementedError();
}

@Riverpod(dependencies: [clientService])
class OverrideRequestList extends _$OverrideRequestList {
  @override
  Future<List<OverrideRequest>> build() async {
    final data = await ref
        .watch(clientServiceProvider)
        ?.getRequestOverrides(rpc.Empty());
    if (data == null) return const [];
    return data.values
        .map((it) => OverrideRequest.fromJson(it.jsonValue.toJson()))
        .toList();
  }
}

Future<void> actionAddOverrideRequest(
    WidgetRef ref, OverrideRequest overrideRequest) async {
  await ref.read(clientServiceProvider)?.addRequestOverrides(
        overrideRequest.toJson().toRpcJson().jsonValue,
      );
  ref.invalidate(overrideRequestListProvider);
}

Future<void> actionRemoveOverrideRequest(
    WidgetRef ref, OverrideRequest overrideRequest) async {
  await ref.read(clientServiceProvider)?.removeRequestOverrides(
        overrideRequest.toJson().toRpcJson().jsonValue,
      );
  ref.invalidate(overrideRequestListProvider);
}

Future<void> actionUpdateOverrideRequest(
    WidgetRef ref, OverrideRequest overrideRequest) async {
  await ref.read(clientServiceProvider)?.updateRequestOverrides(
    overrideRequest.toJson().toRpcJson().jsonValue,
  );
  ref.invalidate(overrideRequestListProvider);
}
