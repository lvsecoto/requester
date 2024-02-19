import 'package:grpc/grpc.dart';
import 'package:requester_client/requester_client.dart';
import 'package:requester_client/src/override/override.dart';
import 'package:requester_client/src/rpc/rpc.dart' as rpc;

import 'log/log.dart';

class RequesterClientService extends rpc.RequesterClientServiceBase {
  /// Requester客户端提供服务实现
  RequesterClientService({
    required this.clientInfoProvider,
    required this.logProvider,
    required this.overrideProvider,
    required this.onClientIdChanged,
    required this.onIdentify,
  });

  /// 向Requester提供客户端信息
  final ClientInfoProvider clientInfoProvider;

  final LogProvider logProvider;

  final OverrideProvider overrideProvider;

  /// 客户端id改变回调
  final Function() onClientIdChanged;

  /// 当发起识别命令
  final Function() onIdentify;

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
  Future<rpc.Empty> identify(ServiceCall call, rpc.Empty request) async {
    onIdentify();
    return rpc.Empty();
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
    final hostPort = await logProvider.getLogHostPort();
    return rpc.LogHostPort(host: hostPort.host, port: hostPort.port);
  }

  @override
  Future<rpc.Empty> setLogHostPort(
      ServiceCall call, rpc.LogHostPort request) async {
    final hostPort = HostPort(
      host: request.host,
      port: request.port,
    );
    await logProvider.setLogHostPort(hostPort);
    return rpc.Empty();
  }

  @override
  Future<rpc.Empty> addRequestOverrides(
      ServiceCall call, rpc.RpcJson request) async {
    await overrideProvider.addOverride(
      OverrideRequest.fromJson(request.toJson()).copyWith(
        id: DateTime.now().toString(),
      ),
    );
    return rpc.Empty();
  }

  @override
  Future<rpc.RpcJsonListValue> getRequestOverrides(
      ServiceCall call, rpc.Empty request) async {
    final overrides = await overrideProvider.getOverrideList();
    return rpc.RpcJsonListValue(
      values: overrides.map((it) => it.toJson().toRpcJson()).toList(),
    );
  }

  @override
  Future<rpc.Empty> removeRequestOverrides(
      ServiceCall call, rpc.RpcJson request) async {
    await overrideProvider.removeOverride(
      OverrideRequest.fromJson(request.toJson()),
    );
    return rpc.Empty();
  }

  @override
  Future<rpc.Empty> updateRequestOverrides(ServiceCall call, rpc.RpcJson request) async {
    await overrideProvider.updateOverride(
      OverrideRequest.fromJson(request.toJson()),
    );
    return rpc.Empty();
  }
}
