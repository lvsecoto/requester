import 'package:grpc/grpc.dart';
import 'package:requester_client/requester_client.dart';
import 'package:requester_client/src/rpc/rpc.dart' as rpc;

class RequesterClientService extends rpc.RequesterClientServiceBase {
  /// Requester客户端提供服务实现
  RequesterClientService({
    required this.clientInfoProvider,
    required this.onClientIdChanged,
  });

  /// 向Requester提供客户端信息
  final ClientInfoProvider clientInfoProvider;

  /// 客户端id改变回调
  final Function() onClientIdChanged;

  @override
  Future<rpc.Empty> setClientId(ServiceCall call, rpc.ClientId request) async {
    await RequesterClient.setClientId(request.id);
    onClientIdChanged();
    return rpc.Empty();
  }

  @override
  Future<rpc.ClientId> getClientId(ServiceCall call, rpc.Empty request) async {
    final id = await RequesterClient.getClientId();
    return rpc.ClientId(id: id);
  }

  @override
  Future<rpc.Empty> updateClientInfo(
      ServiceCall call, rpc.ClientInfoEntry request) async {
    clientInfoProvider.onRequesterUpdateValue(request.key, request.value.value);
    return rpc.Empty();
  }

  @override
  Stream<rpc.ClientInfo> observeClientInfo(
      ServiceCall call, rpc.Empty request) {
    return clientInfoProvider.stream.map(
      (it) => rpc.ClientInfo(
        meta: it.map(
          (key, value) => MapEntry(key, rpc.ClientMetaValue(value: value)),
        ),
      ),
    );
  }

  @override
  Future<rpc.LogHostPort> getLogHostPort(
      ServiceCall call, rpc.Empty request) async {
    return rpc.LogHostPort(port: 2, host: 'fasdf');
  }

  @override
  Future<rpc.Empty> setLogHostPort(
      ServiceCall call, rpc.LogHostPort request) async {
    return rpc.Empty();
  }
}
