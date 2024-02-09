import 'dart:io';

import 'package:grpc/grpc.dart';
import 'package:requester_client/src/rpc/rpc.dart' as rpc;

import 'client_info/client_info.dart';

class RequesterClientService extends rpc.RequesterClientServiceBase {
  /// Requester客户端提供服务实现
  RequesterClientService({
    required this.clientInfoProvider,
  });

  /// 向Requester提供客户端信息
  final ClientInfoProvider clientInfoProvider;

  @override
  Future<rpc.Empty> updateClientInfo(ServiceCall call, rpc.ClientInfoEntry request) async {
    clientInfoProvider.onRequesterUpdateValue(request.key, request.value.value);
    return rpc.Empty();
  }

  @override
  Stream<rpc.ClientInfo> observeClientInfo(ServiceCall call, rpc.Empty request) {
    return clientInfoProvider.stream.map(
      (it) => rpc.ClientInfo(
        meta: it.map(
          (key, value) => MapEntry(key, rpc.ClientMetaValue(value: value)),
        ),
      ),
    );
  }

  // @override
  // Future<rpc.ClientInfo> getClientInfo(
  //   ServiceCall call,
  //   rpc.Empty request,
  // ) async =>
  //     rpc.ClientInfo(
  //       meta: clientInfoProvider().map(
  //         (key, value) => MapEntry(
  //           key,
  //           rpc.ClientMetaValue(
  //             value: value,
  //           ),
  //         ),
  //       ),
  //     );

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
