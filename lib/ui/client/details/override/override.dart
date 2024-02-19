import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:requester/client/client.dart';
import 'package:requester/ui/client/details/override/provider/provider.dart' as provider;
import 'package:requester_client/requester_client.dart';

import 'widget/content_widget.dart';

class ClientRequestOverrideScreen extends StatelessWidget {
  const ClientRequestOverrideScreen({
    super.key,
    required this.hostPort,
  });

  /// 客户端地址和端口
  final HostPort hostPort;

  @override
  Widget build(BuildContext context) {
    return RequesterClientServiceControllerWidget(
      hostPort: hostPort,
      child: HookBuilder(builder: (context) {
        // todo 提取
        final controller = RequesterClientServiceController.of(context);
        final clientService =
            useListenableSelector(controller, () => controller.clientService);
        return ProviderScope(
          overrides: [
            provider.clientServiceProvider.overrideWithValue(clientService),
          ],
          child: const ContentWidget(),
        );
      }),
    );
  }
}
