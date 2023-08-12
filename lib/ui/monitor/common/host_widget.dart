import 'package:flutter/material.dart';
import 'package:requester/domain/monitor/model.dart';

class HostWidget extends StatelessWidget {
  /// 主机地址
  const HostWidget({Key? key, required this.request}) : super(key: key);

  final MonitorLogRequest request;

  @override
  Widget build(BuildContext context) {
    final uri = Uri.tryParse(request.logRequest.uri);
    final host = uri?.host;
    return Text(host ?? '');
  }
}
