import 'package:flutter/material.dart';
import 'package:requester/domain/monitor/model.dart';
import 'package:requester/ui/monitor/common/host_widget.dart';
import 'package:requester/ui/monitor/common/method_widget.dart';
import 'package:requester/ui/monitor/common/network_status.dart';
import 'package:requester/ui/monitor/common/path_widget.dart';

class RequestItemWidget extends StatelessWidget {
  const RequestItemWidget({
    super.key,
    required this.request,
  });

  final MonitorRequest request;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              MethodWidget(request: request),
              const SizedBox(width: 8),
              PathWidget(request: request),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              NetworkStatus(request: request),
              const SizedBox(width: 8),
              HostWidget(request: request),
            ],
          ),
        ],
      ),
    );
  }
}
