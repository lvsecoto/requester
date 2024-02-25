import 'package:drift/drift.dart' hide JsonKey;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:requester/data/db/db.dart';
import 'package:requester_client/requester_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'model.dart';

part 'provider.dart';

part 'client.g.dart';

part 'client.freezed.dart';

@riverpod
ClientManager clientManager(ClientManagerRef ref) {
  return ClientManager(ref);
}

class ClientManager {
  ClientManager(this._ref);

  final AutoDisposeRef<ClientManager> _ref;

  late final _table = _ref.read(appDataBaseProvider).clientTable;

  var _cachedClients = <RequesterClient>[];

  /// 每当[RequesterClient]列表刷新后，都要回调
  void onClientsFoundChanged(List<RequesterClient> clients) {
    final changedClients =
        clients.where((client) => !_cachedClients.contains(client)).toList();
    _cachedClients = changedClients;

    _table.insertAll(
      clients
          .map((client) => ClientTableCompanion.insert(
                appName: client.appName,
                appVersion: client.appVersion,
                clientUid: client.clientUid,
                clientId: client.clientId,
                host: client.hostPort.host,
                port: client.hostPort.port,
              ))
          .toList(),
      mode: InsertMode.insertOrReplace,
    );
  }

  /// 用UID(从缓存)获取Requester信息
  Future<RequesterClient> _getRequesterClient(String clientUid) async {
    final data = await (_table.select()
          ..where((tbl) => tbl.clientUid.equals(clientUid)))
        .getSingle();
    return RequesterClient(
      clientId: data.clientId,
      clientUid: clientUid,
      appName: data.appName,
      appVersion: data.appVersion,
      hostPort: HostPort(
        host: data.host,
        port: data.port,
      ),
    );
  }

  /// 提供RequesterClient详情
  late final provideRequesterClient = loadRequesterClientProvider;
}
