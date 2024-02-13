import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:requester/domain/log/log.dart';

class RequestSummaryWidget extends StatelessWidget {
  /// 请求概览，包括请求的路径分析和请求时间
  const RequestSummaryWidget({
    super.key,
    required this.logRequest,
    this.leading,
  });

  final Widget? leading;

  final LogRequest logRequest;

  static final requestTimeFormatter = DateFormat('HH:mm:ss');

  @override
  Widget build(BuildContext context) {
    final uri = Uri.tryParse(logRequest.requestPath);
    final segments = uri?.pathSegments ?? [];
    if (segments.isEmpty) {
      return const Text('/');
    }

    final lastSegment = segments.lastOrNull ?? '';
    final textTheme = Theme.of(context).textTheme;
    final requestTime = requestTimeFormatter.format(logRequest.time);
    return Text.rich(
      TextSpan(children: [
        if (leading != null)
          WidgetSpan(child: leading!, alignment: PlaceholderAlignment.middle),

        // 最后个路径
        TextSpan(
            text: '\u{200B}/$lastSegment',
            style: textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.bold,
            )),

        // 请求时间
        TextSpan(text: '\n$requestTime', style: textTheme.bodySmall),

        // 全路径
        TextSpan(
          text: ' ${segments.map((it) => '\u{200B}/$it').join()}',
          style: textTheme.bodyMedium,
        ),
      ]),
    );
  }
}
