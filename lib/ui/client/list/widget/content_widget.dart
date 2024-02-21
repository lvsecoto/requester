import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:requester/service/service.dart';
import 'package:requester_client/requester_client.dart';

import '../../../../route/route.dart';
import 'client_item_widget.dart';

class ContentWidget extends HookWidget {
  const ContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('设备列表'),
      ),
      body: CustomScrollView(
        slivers: [
          HookBuilder(builder: (context) {
            final controller = RequesterClientDiscoveryController.of(context);
            final clients =
                useListenableSelector(controller, () => controller.clients);
            return DiffSliverAnimatedList(
              items: clients,
              keySelector: (item) => item.hostPort,
              itemBuilder: (context, client) => ClientItemWidget(
                client: client,
                onTap: (client) {
                  RequesterClientDetailsRoute.fromClient(client).go(
                    context,
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}

class DialogContentWidget extends HookWidget {
  const DialogContentWidget({
    super.key,
    required this.onSelect,
  });

  final ValueChanged<RequesterClient> onSelect;

  @override
  Widget build(BuildContext context) {
    return RequesterClientDiscoveryControllerWidget(
      child: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          HookBuilder(builder: (context) {
            final controller = RequesterClientDiscoveryController.of(context);
            final clients =
                useListenableSelector(controller, () => controller.clients);
            return DiffSliverAnimatedList(
              items: clients,
              keySelector: (item) => item.hostPort,
              itemBuilder: (context, client) => ClientItemWidget(
                client: client,
                onTap: onSelect,
              ),
            );
          }),
        ],
      ),
    );
  }
}
