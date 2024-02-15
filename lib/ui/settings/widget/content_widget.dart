import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:requester/route/route.dart';

class ContentWidget extends StatelessWidget {
  const ContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.monitor_heart),
          selectedTileColor: Theme.of(context).colorScheme.primaryContainer,
          selected: const MonitorSettingsRoute().location == location,
          title: const Text('监视器'),
          onTap: () {
            const MonitorSettingsRoute().go(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.monitor_heart),
          selectedTileColor: Theme.of(context).colorScheme.primaryContainer,
          selected: const DocumentSettingsRoute().location == location,
          title: const Text('文档配置'),
          onTap: () {
            const DocumentSettingsRoute().go(context);
          },
        ),
      ],
    );
  }
}
