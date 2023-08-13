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
