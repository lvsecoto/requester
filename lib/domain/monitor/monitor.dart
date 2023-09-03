import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:requester/domain/log/log.dart';
import 'package:requester/domain/monitor/provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:synchronized/synchronized.dart';

export 'model.dart';

part 'monitor.g.dart';

@riverpod
Monitor monitor(MonitorRef ref) {
  ref.keepAlive();
  final port = ref.watch(monitorPortProvider);
  if (port == null) {
    return Monitor._stop();
  }
  final monitor = Monitor(
    port: port,
    onLog: (log) {
      ref.read(monitorRequestListProvider.notifier).onReceivedNew(log);
    },
  )..start();
  ref.onDispose(() {
    monitor.stop();
  });
  return monitor;
}

class Monitor {
  static final lock = Lock();

  /// 不能做任何操作
  static Monitor _stop() {
    return Monitor(onLog: (_) {}, port: 0);
  }

  Monitor({
    required this.onLog,
    required this.port,
  });

  /// 收到日志后的回调
  final void Function(Log) onLog;

  /// 监听端口
  final int port;

  /// 设别
  ServerSocket? server;

  /// 启动服务
  Future<void> start() => lock.synchronized(() async {
        var server = this.server;
        if (server != null) {
          server.close();
        }
        server = await ServerSocket.bind(InternetAddress.anyIPv4, port);
        this.server = server..listen((client) {
          client.listen((event) {
            final json = utf8.decode(event);
            try {
              onLog(
                Log.fromJson(jsonDecode(json)),
              );
            } catch (e) {
              debugPrint(e.toString());
            }
          });
        });
      });

  Future<void> stop() => lock.synchronized(() async {
        await server?.close();
      });
}
