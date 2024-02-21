library intranet_ip;

import 'dart:core';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:collection/collection.dart';
import 'package:network_info_plus/network_info_plus.dart';

/// 获取局域网IP
Future<String> getIntranetIpv4() async {
  final info = NetworkInfo();
  final ip = await info.getWifiIP();
  if (ip != null) {
    return ip;
  }

  // 这种方式适合Windows有线网络
  const len = 16;
  final token = randomUInt8List(len);
  final socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 0);

  socket.readEventsEnabled = true;
  socket.broadcastEnabled = true;
  final ret = socket.timeout(const Duration(milliseconds: 500), onTimeout: (sink) {
    sink.close();
  }).expand<InternetAddress>((event) {
    if (event == RawSocketEvent.read) {
      final dg = socket.receive();
      if (dg != null &&
          dg.data.length == len &&
          const ListEquality().equals(dg.data, token)) {
        socket.close();
        return [];
      }
    }
    return [];
  }).first;

  socket.send(token, InternetAddress("255.255.255.255"), socket.port);
  return (await ret).host;
}

Uint8List randomUInt8List(int length) {
  assert(length > 0);

  final random = Random();
  final ret = Uint8List(length);

  for (var i = 0; i < length; i++) {
    ret[i] = random.nextInt(256);
  }

  return ret;
}