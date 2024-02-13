import 'package:flutter/material.dart';
import 'package:requester/domain/log/log.dart';

class HostWidget extends StatelessWidget {

  /// 主机地址
  const HostWidget({
    super.key,
    required this.logRequest,
  });

  final LogRequest logRequest;

  @override
  Widget build(BuildContext context) {
    final uri = Uri.tryParse(logRequest.requestPath);
    final host = uri?.host;
    return Text(host ?? '');
  }
}
