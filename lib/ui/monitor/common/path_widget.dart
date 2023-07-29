import 'package:common_dc/common_dc.dart';
import 'package:flutter/material.dart';
import 'package:requester/domain/monitor/model.dart';

class PathWidget extends StatelessWidget {
  /// 请求路径
  const PathWidget({Key? key, required this.request}) : super(key: key);

  final MonitorRequest request;

  @override
  Widget build(BuildContext context) {
    final uri = Uri.tryParse(request.logRequest.uri);
    final segments = uri?.pathSegments ?? [];
    if (segments.isEmpty) {
      return const Text('/');
    }

    final lastSegment = segments.lastOrNull;
    final preSegments = segments.take(segments.length - 1);
    final textTheme = Theme.of(context).textTheme;
    return Text.rich(
      TextSpan(children: [
        TextSpan(
            text: '/${preSegments.map((it) => '$it/').join()}',
            style: textTheme.bodyLarge),
        TextSpan(text: lastSegment, style: textTheme.titleMedium!.bold),
      ]),
    );
  }
}
