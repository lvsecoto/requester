import 'package:flutter/material.dart';
import 'package:requester/common/tag_widget.dart';
import 'package:requester/domain/monitor/monitor.dart';

class MethodWidget extends StatelessWidget {
  const MethodWidget({Key? key, required this.request}) : super(key: key);

  final MonitorLogRequest request;

  @override
  Widget build(BuildContext context) {
    final method = request.logRequest.method;
    return switch (method.toLowerCase()) {
      'get' => const TagWidget.green(label: Text('GET')),
      'post' => const TagWidget.yellow(label: Text('POST')),
      'put' => const TagWidget.blue(label: Text('POST')),
      'delete' => const TagWidget.red(label: Text('POST')),
      _ => TagWidget.grey(label: Text(method))
    };
  }
}
