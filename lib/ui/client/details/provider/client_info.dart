part of 'provider.dart';

typedef ClientInfoValue = MapEntry<String, rpc.ClientMetaValue>;

extension ClientInfoValueEx on ClientInfoValue {
  String get name => key;
  String get data => this.value.value;
}

/// 观察Requester客户端信息
@Riverpod(dependencies: [clientService])
Stream<Map<String, rpc.ClientMetaValue>> _observeClientInfo(
    _ObserveClientInfoRef ref) async* {
  final client = ref.watch(clientServiceProvider);
  if (client == null) yield* Stream.value({});
  yield* client!.observeClientInfo(rpc.Empty()).map(
        (it) => it.meta,
  );
}

/// 观察设备信息条目
List<ClientInfoValue> watchClientInfoValues(WidgetRef ref) {
  return ref.watch(_observeClientInfoProvider).valueOrNull?.entries.toList() ?? [];
}

/// 更新客户端信息
void actionUpdateClientInfoEntry(WidgetRef ref, {
  required String key,
  required String value,
}) {
  ref.read(clientServiceProvider)?.updateClientInfo(
    rpc.ClientInfoEntry(key: key, value: rpc.ClientMetaValue(value: value)),
  );
}
