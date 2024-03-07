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

import '../common/common.pb.dart' as $1;
import 'client_service.pb.dart' as $0;

export 'client_service.pb.dart';

@$pb.GrpcServiceName('client_service.RequesterClientService')
class RequesterClientServiceClient extends $grpc.Client {
  static final _$setClientId = $grpc.ClientMethod<$0.ClientId, $1.Empty>(
      '/client_service.RequesterClientService/SetClientId',
      ($0.ClientId value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$getClientId = $grpc.ClientMethod<$1.Empty, $0.ClientId>(
      '/client_service.RequesterClientService/GetClientId',
      ($1.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ClientId.fromBuffer(value));
  static final _$identify = $grpc.ClientMethod<$1.Empty, $1.Empty>(
      '/client_service.RequesterClientService/Identify',
      ($1.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$observeClientInfo = $grpc.ClientMethod<$1.Empty, $0.ClientInfo>(
      '/client_service.RequesterClientService/ObserveClientInfo',
      ($1.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ClientInfo.fromBuffer(value));
  static final _$updateClientInfo = $grpc.ClientMethod<$0.ClientInfoEntry, $1.Empty>(
      '/client_service.RequesterClientService/UpdateClientInfo',
      ($0.ClientInfoEntry value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$setLogHostPort = $grpc.ClientMethod<$0.LogHostPort, $1.Empty>(
      '/client_service.RequesterClientService/SetLogHostPort',
      ($0.LogHostPort value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$getLogHostPort = $grpc.ClientMethod<$1.Empty, $0.LogHostPort>(
      '/client_service.RequesterClientService/GetLogHostPort',
      ($1.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.LogHostPort.fromBuffer(value));
  static final _$getRequestOverrides = $grpc.ClientMethod<$1.Empty, $1.RpcJsonListValue>(
      '/client_service.RequesterClientService/GetRequestOverrides',
      ($1.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.RpcJsonListValue.fromBuffer(value));
  static final _$addRequestOverrides = $grpc.ClientMethod<$1.RpcJson, $1.Empty>(
      '/client_service.RequesterClientService/AddRequestOverrides',
      ($1.RpcJson value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$removeRequestOverrides = $grpc.ClientMethod<$1.RpcJson, $1.Empty>(
      '/client_service.RequesterClientService/RemoveRequestOverrides',
      ($1.RpcJson value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$updateRequestOverrides = $grpc.ClientMethod<$1.RpcJson, $1.Empty>(
      '/client_service.RequesterClientService/UpdateRequestOverrides',
      ($1.RpcJson value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$observeDisplayPerformance = $grpc.ClientMethod<$1.Empty, $0.DisplayPerformance>(
      '/client_service.RequesterClientService/ObserveDisplayPerformance',
      ($1.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.DisplayPerformance.fromBuffer(value));
  static final _$observeAppState = $grpc.ClientMethod<$1.Empty, $0.ClientAppState>(
      '/client_service.RequesterClientService/ObserveAppState',
      ($1.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ClientAppState.fromBuffer(value));

  RequesterClientServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$1.Empty> setClientId($0.ClientId request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setClientId, request, options: options);
  }

  $grpc.ResponseFuture<$0.ClientId> getClientId($1.Empty request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getClientId, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> identify($1.Empty request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$identify, request, options: options);
  }

  $grpc.ResponseStream<$0.ClientInfo> observeClientInfo($1.Empty request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$observeClientInfo, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseFuture<$1.Empty> updateClientInfo($0.ClientInfoEntry request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateClientInfo, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> setLogHostPort($0.LogHostPort request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setLogHostPort, request, options: options);
  }

  $grpc.ResponseFuture<$0.LogHostPort> getLogHostPort($1.Empty request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getLogHostPort, request, options: options);
  }

  $grpc.ResponseFuture<$1.RpcJsonListValue> getRequestOverrides($1.Empty request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getRequestOverrides, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> addRequestOverrides($1.RpcJson request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addRequestOverrides, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> removeRequestOverrides($1.RpcJson request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removeRequestOverrides, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> updateRequestOverrides($1.RpcJson request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateRequestOverrides, request, options: options);
  }

  $grpc.ResponseStream<$0.DisplayPerformance> observeDisplayPerformance($1.Empty request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$observeDisplayPerformance, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseStream<$0.ClientAppState> observeAppState($1.Empty request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$observeAppState, $async.Stream.fromIterable([request]), options: options);
  }
}

@$pb.GrpcServiceName('client_service.RequesterClientService')
abstract class RequesterClientServiceBase extends $grpc.Service {
  $core.String get $name => 'client_service.RequesterClientService';

  RequesterClientServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.ClientId, $1.Empty>(
        'SetClientId',
        setClientId_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ClientId.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $0.ClientId>(
        'GetClientId',
        getClientId_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($0.ClientId value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $1.Empty>(
        'Identify',
        identify_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $0.ClientInfo>(
        'ObserveClientInfo',
        observeClientInfo_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($0.ClientInfo value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ClientInfoEntry, $1.Empty>(
        'UpdateClientInfo',
        updateClientInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ClientInfoEntry.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.LogHostPort, $1.Empty>(
        'SetLogHostPort',
        setLogHostPort_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.LogHostPort.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $0.LogHostPort>(
        'GetLogHostPort',
        getLogHostPort_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($0.LogHostPort value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $1.RpcJsonListValue>(
        'GetRequestOverrides',
        getRequestOverrides_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($1.RpcJsonListValue value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.RpcJson, $1.Empty>(
        'AddRequestOverrides',
        addRequestOverrides_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.RpcJson.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.RpcJson, $1.Empty>(
        'RemoveRequestOverrides',
        removeRequestOverrides_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.RpcJson.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.RpcJson, $1.Empty>(
        'UpdateRequestOverrides',
        updateRequestOverrides_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.RpcJson.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $0.DisplayPerformance>(
        'ObserveDisplayPerformance',
        observeDisplayPerformance_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($0.DisplayPerformance value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $0.ClientAppState>(
        'ObserveAppState',
        observeAppState_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($0.ClientAppState value) => value.writeToBuffer()));
  }

  $async.Future<$1.Empty> setClientId_Pre($grpc.ServiceCall call, $async.Future<$0.ClientId> request) async {
    return setClientId(call, await request);
  }

  $async.Future<$0.ClientId> getClientId_Pre($grpc.ServiceCall call, $async.Future<$1.Empty> request) async {
    return getClientId(call, await request);
  }

  $async.Future<$1.Empty> identify_Pre($grpc.ServiceCall call, $async.Future<$1.Empty> request) async {
    return identify(call, await request);
  }

  $async.Stream<$0.ClientInfo> observeClientInfo_Pre($grpc.ServiceCall call, $async.Future<$1.Empty> request) async* {
    yield* observeClientInfo(call, await request);
  }

  $async.Future<$1.Empty> updateClientInfo_Pre($grpc.ServiceCall call, $async.Future<$0.ClientInfoEntry> request) async {
    return updateClientInfo(call, await request);
  }

  $async.Future<$1.Empty> setLogHostPort_Pre($grpc.ServiceCall call, $async.Future<$0.LogHostPort> request) async {
    return setLogHostPort(call, await request);
  }

  $async.Future<$0.LogHostPort> getLogHostPort_Pre($grpc.ServiceCall call, $async.Future<$1.Empty> request) async {
    return getLogHostPort(call, await request);
  }

  $async.Future<$1.RpcJsonListValue> getRequestOverrides_Pre($grpc.ServiceCall call, $async.Future<$1.Empty> request) async {
    return getRequestOverrides(call, await request);
  }

  $async.Future<$1.Empty> addRequestOverrides_Pre($grpc.ServiceCall call, $async.Future<$1.RpcJson> request) async {
    return addRequestOverrides(call, await request);
  }

  $async.Future<$1.Empty> removeRequestOverrides_Pre($grpc.ServiceCall call, $async.Future<$1.RpcJson> request) async {
    return removeRequestOverrides(call, await request);
  }

  $async.Future<$1.Empty> updateRequestOverrides_Pre($grpc.ServiceCall call, $async.Future<$1.RpcJson> request) async {
    return updateRequestOverrides(call, await request);
  }

  $async.Stream<$0.DisplayPerformance> observeDisplayPerformance_Pre($grpc.ServiceCall call, $async.Future<$1.Empty> request) async* {
    yield* observeDisplayPerformance(call, await request);
  }

  $async.Stream<$0.ClientAppState> observeAppState_Pre($grpc.ServiceCall call, $async.Future<$1.Empty> request) async* {
    yield* observeAppState(call, await request);
  }

  $async.Future<$1.Empty> setClientId($grpc.ServiceCall call, $0.ClientId request);
  $async.Future<$0.ClientId> getClientId($grpc.ServiceCall call, $1.Empty request);
  $async.Future<$1.Empty> identify($grpc.ServiceCall call, $1.Empty request);
  $async.Stream<$0.ClientInfo> observeClientInfo($grpc.ServiceCall call, $1.Empty request);
  $async.Future<$1.Empty> updateClientInfo($grpc.ServiceCall call, $0.ClientInfoEntry request);
  $async.Future<$1.Empty> setLogHostPort($grpc.ServiceCall call, $0.LogHostPort request);
  $async.Future<$0.LogHostPort> getLogHostPort($grpc.ServiceCall call, $1.Empty request);
  $async.Future<$1.RpcJsonListValue> getRequestOverrides($grpc.ServiceCall call, $1.Empty request);
  $async.Future<$1.Empty> addRequestOverrides($grpc.ServiceCall call, $1.RpcJson request);
  $async.Future<$1.Empty> removeRequestOverrides($grpc.ServiceCall call, $1.RpcJson request);
  $async.Future<$1.Empty> updateRequestOverrides($grpc.ServiceCall call, $1.RpcJson request);
  $async.Stream<$0.DisplayPerformance> observeDisplayPerformance($grpc.ServiceCall call, $1.Empty request);
  $async.Stream<$0.ClientAppState> observeAppState($grpc.ServiceCall call, $1.Empty request);
}
