import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:requester/ui/monitor/request/provider/provider.dart';
import 'package:requester/ui/monitor/request/widget/request_panel.dart';
import 'package:requester/ui/monitor/request/widget/response_panel.dart';

class ContentWidget extends ConsumerWidget {
  const ContentWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final request = ref.watch(loadMonitorRequestProvider).valueOrNull;
    return Scaffold(
      appBar: AppBar(
        title: Text(request?.logRequest.uri.toString() ?? ''),
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: RequestPanel(),
          ),
          Expanded(
            child: ResponsePanel(),
          ),
        ],
      ),
    );
  }
}
