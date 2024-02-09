import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:requester_client/requester_client.dart';
import 'package:requester_common/requester_common.dart';

import '../controller.dart';

class RequesterClientWidget extends HookWidget {
  /// Requester客户端组件
  ///
  /// 让child获得[RequesterClientController]，且让App能被[Requester]软件发现
  ///
  /// 适配
  /// ## iOS/macOS
  ///
  /// <key>NSLocalNetworkUsageDescription</key>
  /// <string>Required to discover local network devices</string>
  /// <key>NSBonjourServices</key>
  /// <array>
  /// <string>_requester._tcp</string>
  /// </array>
  ///
  /// ## Android
  /// <uses-permission android:name="android.permission.INTERNET" />
  /// <uses-permission android:name="android.permission.CHANGE_WIFI_MULTICAST_STATE" />/
  ///
  const RequesterClientWidget({
    super.key,
    required this.child,
    required this.clientInfoProvider,
  });

  final Widget child;

  /// 向requester提供客户端信息
  final ClientInfoProvider clientInfoProvider;

  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(
      () => RequesterClientController(
        port: 5005,
        clientInfoProvider: clientInfoProvider,
      ),
    );
    useEffect(
      () => () {
        controller.dispose();
      },
      [controller],
    );
    useAppLifecycleAware(controller);
    return _RequesterControllerHolder(
      controller: controller,
      child: child,
    );
  }
}

class _RequesterControllerHolder extends StatelessWidget {
  const _RequesterControllerHolder({
    required this.controller,
    required this.child,
  });

  final RequesterClientController controller;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
