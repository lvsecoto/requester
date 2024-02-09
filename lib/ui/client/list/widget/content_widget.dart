import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:requester/app/theme/theme.dart';
import 'package:requester/discovery/discovery.dart';
import 'package:requester/route/route.dart';
import 'package:requester_client/requester_client.dart';

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
                itemBuilder: (context, client) => _Item(
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

class _Item extends StatelessWidget {
  const _Item({
    required this.client,
  });

  final RequesterClient client;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.phone_android_sharp),
      title: Text(client.hostPort.host),
      subtitle: Text(client.hostPort.port.toString()),
      onTap: () {
        RequesterClientDetailsRoute.fromClient(client).go(
          context,
        );
      },
    );
  }
}
