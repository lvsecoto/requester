import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:requester/domain/log/log.dart';
import 'package:requester/domain/monitor/provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'model.dart';
export 'model.dart';

part 'monitor.g.dart';

@riverpod
Monitor monitor(MonitorRef ref) {
  ref.keepAlive();
  return Monitor(onLog: (log) {
    ref.read(monitorRequestListProvider.notifier).onReceivedNew(log);
  })
    ..start();
}

class Monitor {
  Monitor({
    required this.onLog,
  });

  /// 收到日志后的回调
  final void Function(Log) onLog;

  /// 启动服务
  void start() async {
    final server = await ServerSocket.bind(InternetAddress.anyIPv4, 5000);
    server.listen((client) {
      client.listen((event) {
        final json = String.fromCharCodes(event);
        try {
          onLog(
            Log.fromJson(jsonDecode(json)),
          );
        } catch (e) {
          debugPrint(e.toString());
        }
      });
    });
  }
}
