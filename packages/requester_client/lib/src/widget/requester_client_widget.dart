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
    required this.child,
    this.port = 5010,
  });

  final Widget child;

  final int port;

  @override
  Widget build(BuildContext context) {
    final identityAnimation = useAnimationController();
    useEffect(() {
      void onChange(AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          identityAnimation.animateTo(
            identityAnimation.lowerBound,
            duration: const Duration(milliseconds: 120),
          );
        }
      }

      identityAnimation.addStatusListener(onChange);
      return () {
        identityAnimation.removeStatusListener(onChange);
      };
    }, [identityAnimation]);
    final controller = useMemoized(
      () => RequesterClientController(
        port: port,
        onIdentity: () {
          identityAnimation.animateTo(
            identityAnimation.upperBound,
            duration: const Duration(milliseconds: 1500),
            curve: const Interval(
              0,
              0.3,
              curve: Curves.fastOutSlowIn,
            ),
          );
        },
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
      child: Stack(
        textDirection: TextDirection.ltr,
        children: [
          child,
          HookBuilder(builder: (context) {
            return Center(
              child: FadeTransition(
                opacity: identityAnimation,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.black54,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Text(
                      'Requester 客户端',
                      textDirection: TextDirection.ltr,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 32,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
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
