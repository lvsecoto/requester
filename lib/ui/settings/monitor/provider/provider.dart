import 'dart:io';

import 'package:dartx/dartx.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:requester/domain/monitor/provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@riverpod
String monitor(MonitorRef ref) {
  return 'monitor';
}

@riverpod
Future<String> monitorHostPort(MonitorHostPortRef ref) async {
  ref.keepAlive();
  final port = await ref.watch(monitorPortProvider.notifier).future;
  final String? ip;
  if (Platform.isWindows) {
    final result = await Process.run('ipconfig', []);
    final out = result.stdout as String;
    ip = out.split('\r\n').filter((it) => it.contains('IPv4')).first.split(':').last.trim();
  } else {
    ip = await NetworkInfo().getWifiIP();
  }
  return '$ip:$port';
}