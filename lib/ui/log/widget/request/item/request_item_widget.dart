import 'package:common/common.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:requester/app/theme/theme.dart';
import 'package:requester/domain/log/log.dart';
import 'package:requester/ui/common/common.dart';
import 'package:requester/ui/log/common/common.dart';
import 'package:requester/ui/log/provider/provider.dart';

class RequestItemWidget extends StatelessWidget {
  const RequestItemWidget({
    super.key,
    required this.logRequest,
  });

  final LogRequest logRequest;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RequestSummaryWidget(
            leading: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: MethodWidget(logRequest: logRequest),
            ),
            logRequest: logRequest,
          ),
          const Gap(4),
          Consumer(builder: (context, ref, _) {
            final summary = watchRequestDocumentSummary(ref, logRequest);
            return AnimatedVisibilityWidget(
              isVisible: summary.isNotBlank,
              animationWidgetBuilder:
                  AnimatedVisibilityWidget.verticalAnimationWidgetBuilder,
              child: DocumentText(
                summary,
              ),
            );
          }),
          const Gap(2),
          HostWidget(logRequest: logRequest),
          const Gap(6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StatusCodeWidget(request: logRequest),
              const Gap(8),
              NetworkStatus(logRequest: logRequest),
              const Spacer(),
              _ClientDetails(logRequest: logRequest),
            ],
          ),
        ],
      ),
    );
  }
}

class _ClientDetails extends ConsumerWidget {
  const _ClientDetails({
    required this.logRequest,
  });

  final LogRequest logRequest;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = watchRequestClientSummary(ref, logRequest);
    if (summary == null) {
      return const Text(
        '未知客户端',
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Icon(Icons.devices, size: 14),
        const Gap(4),
        DefaultTextStyle(
          style: Theme.of(context).textTheme.bodySmall!.bold,
          child: Text(summary),
        ),
      ],
    );
  }
}
