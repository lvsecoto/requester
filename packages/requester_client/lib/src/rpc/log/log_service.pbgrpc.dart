//
//  Generated code. Do not modify.
//  source: log/log_service.proto
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
import 'log_service.pb.dart' as $2;

export 'log_service.pb.dart';

@$pb.GrpcServiceName('log_service.RequesterLogService')
class RequesterLogServiceClient extends $grpc.Client {
  static final _$sendRequest = $grpc.ClientMethod<$2.LogRequest, $1.Empty>(
      '/log_service.RequesterLogService/SendRequest',
      ($2.LogRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$sendResponse = $grpc.ClientMethod<$2.LogResponse, $1.Empty>(
      '/log_service.RequesterLogService/SendResponse',
      ($2.LogResponse value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$logAppSate = $grpc.ClientMethod<$2.LogAppState, $1.Empty>(
      '/log_service.RequesterLogService/LogAppSate',
      ($2.LogAppState value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));

  RequesterLogServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$1.Empty> sendRequest($2.LogRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendRequest, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> sendResponse($2.LogResponse request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendResponse, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> logAppSate($2.LogAppState request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$logAppSate, request, options: options);
  }
}

@$pb.GrpcServiceName('log_service.RequesterLogService')
abstract class RequesterLogServiceBase extends $grpc.Service {
  $core.String get $name => 'log_service.RequesterLogService';

  RequesterLogServiceBase() {
    $addMethod($grpc.ServiceMethod<$2.LogRequest, $1.Empty>(
        'SendRequest',
        sendRequest_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.LogRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.LogResponse, $1.Empty>(
        'SendResponse',
        sendResponse_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.LogResponse.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.LogAppState, $1.Empty>(
        'LogAppSate',
        logAppSate_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.LogAppState.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$1.Empty> sendRequest_Pre($grpc.ServiceCall call, $async.Future<$2.LogRequest> request) async {
    return sendRequest(call, await request);
  }

  $async.Future<$1.Empty> sendResponse_Pre($grpc.ServiceCall call, $async.Future<$2.LogResponse> request) async {
    return sendResponse(call, await request);
  }

  $async.Future<$1.Empty> logAppSate_Pre($grpc.ServiceCall call, $async.Future<$2.LogAppState> request) async {
    return logAppSate(call, await request);
  }

  $async.Future<$1.Empty> sendRequest($grpc.ServiceCall call, $2.LogRequest request);
  $async.Future<$1.Empty> sendResponse($grpc.ServiceCall call, $2.LogResponse request);
  $async.Future<$1.Empty> logAppSate($grpc.ServiceCall call, $2.LogAppState request);
}
