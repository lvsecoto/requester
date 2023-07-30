import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:requester/ui/monitor/common/data_widget.dart';
import 'package:requester/ui/monitor/request/provider/provider.dart';
import 'package:requester/ui/monitor/request/widget/panel_widget.dart';

class RequestPanel extends ConsumerWidget {
  const RequestPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final request =
        ref.watch(loadMonitorRequestProvider).valueOrNull?.logRequest;
    return PanelWidget(
      margin: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 8),
      title: const Text('请求'),
      child: DataWidget(
        data: request?.data ?? '',
      ),
    );
  }
}
