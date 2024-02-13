import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:requester/ui/monitor/request/provider/provider.dart';

import 'panel_widget.dart';
import 'tab_panel_widget.dart';

class RequestPanel extends HookConsumerWidget {
  const RequestPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final request = loadLogRequest(ref);

    var query = <String, String>{};
    final uri = request?.requestPath;
    if (uri != null) {
      query = Uri.tryParse(uri)?.queryParameters ?? {};
    }

    int? defaultTab;
    if (request != null) {
      if (request.requestBody.isNotBlank) {
        defaultTab = 0;
      } else if (query.isNotEmpty) {
        defaultTab = 1;
      }
    }

    return PanelWidget(
      margin: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 8),
      title: const Text('请求'),
      child: PanelTabWidget(
        value: defaultTab,
        tabs: [
          PanelTab('Body', 0),
          PanelTab('Query', 1),
          PanelTab('请求头', 2),
        ],
        builder: (context, value, child) => switch (value) {
          // 0 => DataWidget(data: request?.data ?? ''),
          // 1 => ParametersTableWidget(data: query),
          // 2 => ParametersTableWidget(data: request?.headers ?? {}),
          _ => throw '',
        },
      ),
    );
  }
}
