import 'package:flutter/material.dart';
import 'package:requester/domain/log/log.dart';
import 'package:requester/ui/monitor/common/common.dart';

class RequestItemWidget extends StatelessWidget {
  const RequestItemWidget({
    super.key,
    required this.request,
  });

  final LogRequest request;

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
              child: MethodWidget(logRequest: request),
            ),
            logRequest: request,
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              NetworkStatus(logRequest: request),
              const SizedBox(width: 8),
              HostWidget(logRequest: request),
              const SizedBox(width: 8),
              DCStatusCodeWidget(request: request),
            ],
          ),
        ],
      ),
    );
  }
}
