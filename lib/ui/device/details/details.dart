import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:requester/ui/device/details/provider/provider.dart';

import 'widget/content_widget.dart';

class DeviceDetailsScreen extends StatelessWidget {
  const DeviceDetailsScreen({
    super.key,
    required this.hostPort,
  });

  /// 设备的主机地址和端口
  final String hostPort;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        deviceHostPortProvider.overrideWithValue(hostPort)
      ],
      child: const ContentWidget(),
    );
  }
}
