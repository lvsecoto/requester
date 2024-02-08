//
//  Generated code. Do not modify.
//  source: client/client_service.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import '../common/common.pb.dart' as $0;
import 'client_service.pb.dart' as $1;

export 'client_service.pb.dart';

@$pb.GrpcServiceName('requester_client.RequesterClientService')
class RequesterClientServiceClient extends $grpc.Client {
  static final _$getClientInfo = $grpc.ClientMethod<$0.Empty, $1.ClientInfo>(
      '/requester_client.RequesterClientService/GetClientInfo',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ClientInfo.fromBuffer(value));
  static final _$setLogHostPort = $grpc.ClientMethod<$1.LogHostPort, $0.Empty>(
      '/requester_client.RequesterClientService/SetLogHostPort',
      ($1.LogHostPort value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));
  static final _$getLogHostPort = $grpc.ClientMethod<$0.Empty, $1.LogHostPort>(
      '/requester_client.RequesterClientService/GetLogHostPort',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.LogHostPort.fromBuffer(value));

  RequesterClientServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$1.ClientInfo> getClientInfo($0.Empty request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getClientInfo, request, options: options);
  }

  $grpc.ResponseFuture<$0.Empty> setLogHostPort($1.LogHostPort request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setLogHostPort, request, options: options);
  }

  $grpc.ResponseFuture<$1.LogHostPort> getLogHostPort($0.Empty request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getLogHostPort, request, options: options);
  }
}

@$pb.GrpcServiceName('requester_client.RequesterClientService')
abstract class RequesterClientServiceBase extends $grpc.Service {
  $core.String get $name => 'requester_client.RequesterClientService';

  RequesterClientServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Empty, $1.ClientInfo>(
        'GetClientInfo',
        getClientInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($1.ClientInfo value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.LogHostPort, $0.Empty>(
        'SetLogHostPort',
        setLogHostPort_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.LogHostPort.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $1.LogHostPort>(
        'GetLogHostPort',
        getLogHostPort_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($1.LogHostPort value) => value.writeToBuffer()));
  }

  $async.Future<$1.ClientInfo> getClientInfo_Pre($grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return getClientInfo(call, await request);
  }

  $async.Future<$0.Empty> setLogHostPort_Pre($grpc.ServiceCall call, $async.Future<$1.LogHostPort> request) async {
    return setLogHostPort(call, await request);
  }

  $async.Future<$1.LogHostPort> getLogHostPort_Pre($grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return getLogHostPort(call, await request);
  }

  $async.Future<$1.ClientInfo> getClientInfo($grpc.ServiceCall call, $0.Empty request);
  $async.Future<$0.Empty> setLogHostPort($grpc.ServiceCall call, $1.LogHostPort request);
  $async.Future<$1.LogHostPort> getLogHostPort($grpc.ServiceCall call, $0.Empty request);
}
