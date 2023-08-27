//
//  Generated code. Do not modify.
//  source: requester_device.proto
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

import 'requester_device.pb.dart' as $0;

export 'requester_device.pb.dart';

@$pb.GrpcServiceName('requester_device.RequesterDeviceService')
class RequesterDeviceServiceClient extends $grpc.Client {
  static final _$getInfo = $grpc.ClientMethod<$0.RequesterDeviceInfoRequest, $0.RequesterDeviceInfoResponse>(
      '/requester_device.RequesterDeviceService/GetInfo',
      ($0.RequesterDeviceInfoRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.RequesterDeviceInfoResponse.fromBuffer(value));

  RequesterDeviceServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.RequesterDeviceInfoResponse> getInfo($0.RequesterDeviceInfoRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInfo, request, options: options);
  }
}

@$pb.GrpcServiceName('requester_device.RequesterDeviceService')
abstract class RequesterDeviceServiceBase extends $grpc.Service {
  $core.String get $name => 'requester_device.RequesterDeviceService';

  RequesterDeviceServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.RequesterDeviceInfoRequest, $0.RequesterDeviceInfoResponse>(
        'GetInfo',
        getInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RequesterDeviceInfoRequest.fromBuffer(value),
        ($0.RequesterDeviceInfoResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.RequesterDeviceInfoResponse> getInfo_Pre($grpc.ServiceCall call, $async.Future<$0.RequesterDeviceInfoRequest> request) async {
    return getInfo(call, await request);
  }

  $async.Future<$0.RequesterDeviceInfoResponse> getInfo($grpc.ServiceCall call, $0.RequesterDeviceInfoRequest request);
}
