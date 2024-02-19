part of 'route.dart';

class DeviceListDetailsEmptyRoute extends ListDetailsEmptyRoute {
  const DeviceListDetailsEmptyRoute();
}

@TypedShellRoute<RequesterClientListRoute>(
  routes: [
    TypedGoRoute<DeviceListDetailsEmptyRoute>(
      path: '/clientList',
      routes: [
        TypedGoRoute<RequesterClientDetailsRoute>(
          path: 'client/:hostPort',
        ),
      ]
    ),
  ],
)
class RequesterClientListRoute extends ShellRouteData {
  const RequesterClientListRoute();

  // 默认的位置是没选择任何列表内容
  String get location => const DeviceListDetailsEmptyRoute().location;

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return ListDetailsNavigation(
      navigator: navigator,
      isDetailsEmpty: state.uri.path == const DeviceListDetailsEmptyRoute().location,
      list: const RequesterClientListScreen(),
    );
  }
}

class RequesterClientDetailsRoute extends GoRouteData {
  /// 设备的主机地址和端口
  final String hostPort;

  const RequesterClientDetailsRoute(this.hostPort);

  static RequesterClientDetailsRoute fromClient(RequesterClient client) {
    return RequesterClientDetailsRoute(client.hostPort.encode());
  }

  @override
  Widget build(BuildContext context, GoRouterState state) {
    // 仅仅改变:deviceId，路由不会有变化，也不会有路由动画，这里我们自己加上去
    return PageTransitionSwitcher(
      duration: kThemeAnimationDuration,
      transitionBuilder: (Widget child, Animation<double> primaryAnimation,
          Animation<double> secondaryAnimation) {
        return SharedAxisTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.horizontal,
          child: child,
        );
      },
      child: RequesterClientDetailsScreen(
        key: ValueKey(hostPort),
        hostPort: HostPort.decode(hostPort),
      ),
    );
  }
}
