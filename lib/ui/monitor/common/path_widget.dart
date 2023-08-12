import 'package:common_dc/common_dc.dart';
import 'package:flutter/material.dart';
import 'package:requester/domain/monitor/model.dart';

class PathWidget extends StatelessWidget {
  /// 请求路径
  const PathWidget({
    Key? key,
    required this.request,
    this.leading,
  }) : super(key: key);

  final Widget? leading;

  final MonitorLogRequest request;

  @override
  Widget build(BuildContext context) {
    final uri = Uri.tryParse(request.logRequest.uri);
    final segments = uri?.pathSegments ?? [];
    if (segments.isEmpty) {
      return const Text('/');
    }

    final lastSegment = segments.lastOrNull ?? '';
    final textTheme = Theme.of(context).textTheme;
    return Text.rich(
      TextSpan(children: [
        if (leading != null) WidgetSpan(child: leading!,alignment: PlaceholderAlignment.middle),
        TextSpan(text: '\u{200B}/$lastSegment', style: textTheme.titleMedium!.bold),
        TextSpan(
            text: '\n${segments.map((it) => '\u{200B}/$it').join()}',
            style: textTheme.bodyMedium),
      ]),
    );
  }
}
