import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:requester/route/route.dart';
import 'package:requester/ui/monitor/common/common.dart';
import 'package:requester/ui/monitor/request/provider/provider.dart'
    as provider;
import 'package:requester_client/src/model/requester_device.dart';

import 'panel_widget.dart';
import 'tab_panel_widget.dart';

class RequestPanel extends HookConsumerWidget {
  const RequestPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final request = provider.watchLogRequest(ref);
    final queries = request?.requestQueries ?? const {};
    int? defaultTab;
    if (request != null) {
      if (request.requestBody.isNotBlank) {
        defaultTab = 0;
      } else if (queries.isNotEmpty) {
        defaultTab = 1;
      }
    }

    return PanelWidget(
      margin: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 8),
      title: Consumer(builder: (context, ref, _) {
        final client = provider.watchLogRequesterClient(ref);
        return Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text('请求'),
            const Spacer(),
            if (client != null) _Client(client: client),
          ],
        );
      }),
      child: PanelTabWidget(
        initialTab: defaultTab,
        tabs: [
          PanelTab('Body', 0),
          PanelTab('Query', 1),
          PanelTab('请求头', 2),
        ],
        builder: (context, value, child) {
          return switch (value) {
            0 => DataWidget(data: provider.watchLogRequestBody(ref)),
            1 => ParametersTableWidget(
                data: provider.watchLogRequestQueries(ref),
              ),
            2 => ParametersTableWidget(
                data: provider.watchLogRequestHeaders(ref),
              ),
            _ => throw '',
          };
        },
      ),
    );
  }
}

class _Client extends StatelessWidget {

  const _Client({
    required this.client,
  });

  final RequesterClient client;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: const StadiumBorder(),
      onTap: () {
        LogDetailsClientDetailsRoute.fromClient(context, client).go(context);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 12, bottom: 6),
        child: Row(
          children: [
            ClientWidget(requesterClient: client),
            const Gap(4),
            const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Icon(Icons.navigate_next),
            ),
          ],
        ),
      ),
    );
  }
}
