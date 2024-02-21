import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:requester/service/service.dart';
import 'package:requester/ui/client/details/provider/provider.dart';
import 'package:requester_client/requester_client.dart';

import 'widget/content_widget.dart';

export 'override/override.dart';

class RequesterClientDetailsScreen extends StatelessWidget {
  /// Requester Client 详情页面，提供对Requester客户端信息查询，配置等功能
  const RequesterClientDetailsScreen({
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
        final controller = RequesterClientServiceController.of(context);
        final clientService =
            useListenableSelector(controller, () => controller.clientService);
        return ProviderScope(
          overrides: [
            clientServiceProvider.overrideWithValue(clientService),
          ],
          child: const ContentWidget(),
        );
      }),
    );
  }
}
