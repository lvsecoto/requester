import 'package:flutter/material.dart';
import 'package:requester/common/tag_widget.dart';
import 'package:requester/domain/log/log.dart';

class MethodWidget extends StatelessWidget {
  const MethodWidget({
    super.key,
    required this.logRequest,
  });

  final LogRequest logRequest;

  @override
  Widget build(BuildContext context) {
    final method = logRequest.requestMethod;
    return switch (method.toLowerCase()) {
      'get' => const TagWidget.green(label: Text('GET')),
      'post' => const TagWidget.yellow(label: Text('POST')),
      'put' => const TagWidget.blue(label: Text('POST')),
      'delete' => const TagWidget.red(label: Text('POST')),
      _ => TagWidget.grey(label: Text(method.toUpperCase()))
    };
  }
}
