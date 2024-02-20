library intranet_ip;

import 'dart:core';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:collection/collection.dart';

Future<InternetAddress> intranetIpv4() async {
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
        return [dg.address];
      }
    }
    return [];
  }).first;

  socket.send(token, InternetAddress("255.255.255.255"), socket.port);
  return ret;
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