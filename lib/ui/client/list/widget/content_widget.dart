import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:requester/app/theme/theme.dart';
import 'package:requester/discovery/discovery.dart';

import 'client_item_widget.dart';

class ContentWidget extends HookWidget {
  const ContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RequesterClientDiscoveryControllerWidget(
      child: Scaffold(
        backgroundColor: AppTheme.of(context).surfaceContainer,
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
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
