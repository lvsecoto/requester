import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'monitor.g.dart';

@riverpod
Monitor monitor(MonitorRef ref) {
  ref.keepAlive();
  return Monitor()..start();
}

class Monitor {
  void start() async {
    debugPrint('begin');
    final server = await ServerSocket.bind(InternetAddress.anyIPv4, 5000);
    server.listen((client) {
        client.listen((event) {
          print(String.fromCharCodes(event));
        });
    });
  }
}
