part of '../controller.dart';

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

    /// Requester Client对Requester通信端口
    this.port = 5010,

    /// 是否启用Requester Client核心
    this.isEnabled = true,
    required this.child,
  });

  final Widget child;

  final int port;

  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    if (!isEnabled) {
      return child;
    }
    return HookBuilder(builder: (context) {
      final controller = useMemoized(
        () => RequesterClientController(port: port),
      );
      useEffect(
        () => () {
          controller.dispose();
        },
        [controller],
      );
      useFPS(controller);
      useAppState(controller);
      useAppLifecycleAware(controller);
      return _RequesterControllerHolder(
        controller: controller,
        child: RequesterClientIdentityWidget(
          child: child,
        ),
      );
    });
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
