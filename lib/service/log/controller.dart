part of 'log.dart';

@riverpod
LogServiceController logController(LogControllerRef ref) {
  ref.keepAlive();
  return LogServiceController(ref);
}

/// Requester日志接收服务控制器
class LogServiceController extends rpc.RequesterLogServiceBase implements AppLifecycleAware {
  final AutoDisposeRef ref;

  LogServiceController(
    this.ref,
  );

  static LogServiceController of(BuildContext context) {
    return _ControllerHolder._of(context).controller;
  }

  /// 日志端口
  late final int port = ref.watch(logManagerProvider).port;

  /// 释放时，停止发现
  void dispose() {
    _stop();
  }

  grpc.Server? _server;

  /// 启动日志服务
  Future<void> _start() async {
    _server = grpc.Server.create(
      services: [this],
    );
    await _server!.serve(
      port: port,
    );
  }

  /// 停止日志服务
  Future<void> _stop() async {
    if (_server != null) {
      await _server!.shutdown();
    }
  }

  @override
  Future<void> onAppResume() async {
    await _start();
  }

  @override
  Future<void> onAppPause() async {
    await _stop();
  }

  @override
  Future<rpc.Empty> sendRequest(grpc.ServiceCall call, rpc.LogRequest request) async {
    ref.read(logManagerProvider).onReceiveLogRequest(request);
    return rpc.Empty();
  }

  @override
  Future<rpc.Empty> sendResponse(grpc.ServiceCall call, rpc.LogResponse request) async {
    ref.read(logManagerProvider).onReceiveLogResponse(request);
    return rpc.Empty();
  }
}
