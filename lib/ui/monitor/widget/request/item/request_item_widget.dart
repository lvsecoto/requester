import 'package:common/common.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:requester/domain/log/log.dart';
import 'package:requester/ui/common/common.dart';
import 'package:requester/ui/monitor/common/common.dart';
import 'package:requester/ui/monitor/provider/provider.dart';

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
              child: DocumentText(
                summary,
              ),
            );
          }),
          Wrap(
            spacing: 8,
            children: [
              NetworkStatus(logRequest: logRequest),
              HostWidget(logRequest: logRequest),
              DCStatusCodeWidget(request: logRequest),
            ],
          ),
        ],
      ),
    );
  }
}
