part of 'route.dart';

@TypedShellRoute<MonitorRoute>(
  routes: [
    TypedGoRoute<ListDetailsEmptyRoute>(path: '/monitorList', routes: [
      TypedGoRoute<RequestRoute>(path: 'monitor/:id'),
      _requestViewClientRequestOverrideRouteTypedRoute,
    ]),
  ],
)
class MonitorRoute extends ShellRouteData {
  const MonitorRoute();

  // 默认的位置是没选择任何列表内容
  String get location => const ListDetailsEmptyRoute().location;

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return ListDetailsNavigation(
      navigator: navigator,
      isDetailsEmpty: state.uri.path == const ListDetailsEmptyRoute().location,
      list: const MonitorScreen(),
    );
  }
}

class RequestRoute extends GoRouteData {
  final int id;

  const RequestRoute(this.id);

  static RequestRoute? from(GoRouterState state) {
    try {
      return $RequestRouteExtension._fromState(state);
    } catch (ignored) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context, GoRouterState state) {
    // 仅仅改变:requestId，路由不会有变化，也不会有路由动画，这里我们自己加上去
    return PageTransitionSwitcher(
      duration: const Duration(milliseconds: 800),
      transitionBuilder: (Widget child, Animation<double> primaryAnimation,
          Animation<double> secondaryAnimation) {
        return SharedAxisTransition(
          animation: primaryAnimation,
          transitionType: SharedAxisTransitionType.horizontal,
          secondaryAnimation: secondaryAnimation,
          child: child,
        );
      },
      child: RequestScreen(
        key: ValueKey(id),
        id: id,
      ),
    );
  }
}

const _requestViewClientRequestOverrideRouteTypedRoute =
TypedGoRoute<RequestViewClientRequestOverrideRoute>(
  path: 'requestViewClientRequestOverrideRoute',
);

/// 请求重载
class RequestViewClientRequestOverrideRoute extends GoRouteData {
  const RequestViewClientRequestOverrideRoute(
      this.hostPort,
      );

  static RequestViewClientRequestOverrideRoute fromClient(
      RequesterClient client) {
    return RequestViewClientRequestOverrideRoute(client.hostPort.encode());
  }

  /// 设备的主机地址和端口
  final String hostPort;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      ClientRequestOverrideScreen(
        hostPort: HostPort.decode(hostPort),
      );
}
