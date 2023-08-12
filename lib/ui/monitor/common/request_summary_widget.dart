import 'package:common_dc/common_dc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:requester/domain/monitor/model.dart';

class RequestSummaryWidget extends StatelessWidget {
  /// 请求路径
  const RequestSummaryWidget({
    Key? key,
    required this.request,
    this.leading,
  }) : super(key: key);

  final Widget? leading;

  final MonitorLogRequest request;

  static final requestTimeFormatter = DateFormat('hh:mm:ss SSS');

  @override
  Widget build(BuildContext context) {
    final uri = Uri.tryParse(request.logRequest.uri);
    final segments = uri?.pathSegments ?? [];
    if (segments.isEmpty) {
      return const Text('/');
    }

    final lastSegment = segments.lastOrNull ?? '';
    final textTheme = Theme.of(context).textTheme;
    final requestTime = requestTimeFormatter.format(request.logRequest.time);
    return Text.rich(
      TextSpan(children: [
        if (leading != null) WidgetSpan(child: leading!,alignment: PlaceholderAlignment.middle),

        // 最后个路径
        TextSpan(text: '\u{200B}/$lastSegment', style: textTheme.titleMedium!.bold),

        // 请求时间
        TextSpan(text: '\n$requestTime:', style: textTheme.labelMedium!.disabled),

        // 全路径
        TextSpan(
            text: ' ${segments.map((it) => '\u{200B}/$it').join()}',
            style: textTheme.bodyMedium),
      ]),
    );
  }
}
