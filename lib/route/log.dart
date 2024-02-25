part of 'route.dart';

@TypedShellRoute<MonitorRoute>(
  routes: [
    TypedGoRoute<ListDetailsEmptyRoute>(
      path: '/monitorList',
      routes: [
        TypedGoRoute<LogDetailsRoute>(
          path: 'monitor',
          routes: [
            _logDetailsClientDetailsRoute,
          ]
        ),
      ],
    ),
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

class LogDetailsRoute extends GoRouteData {
  /// 日志详情
  const LogDetailsRoute(this.id);

  final int id;

  static LogDetailsRoute? from(GoRouterState state) {
    try {
      return $LogDetailsRouteExtension._fromState(state);
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

const _logDetailsClientDetailsRoute =
    TypedGoRoute<LogDetailsClientDetailsRoute>(
  path: 'clientDetails',
  routes: [
    _logDetailsClientRequestOverrideRoute,
  ],
);

class LogDetailsClientDetailsRoute extends GoRouteData {
  /// 日志详情 - 设备详情路由
  const LogDetailsClientDetailsRoute(this.id, this.hostPort);

  /// 日志id
  final int id;

  /// 设备的主机地址和端口
  final String hostPort;

  static LogDetailsClientDetailsRoute fromClient(
      BuildContext context, RequesterClient client) {
    final state =
        $LogDetailsRouteExtension._fromState(GoRouterState.of(context));
    return LogDetailsClientDetailsRoute(
      state.id,
      client.hostPort.encode(),
    );
  }

  @override
  Widget build(BuildContext context, GoRouterState state) {
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

const _logDetailsClientRequestOverrideRoute =
    TypedGoRoute<LogDetailsClientRequestOverrideRoute>(
  path: 'requestOverride',
);

/// 请求重载
class LogDetailsClientRequestOverrideRoute extends GoRouteData {
  /// 日志详情 - 设备重载路由
  const LogDetailsClientRequestOverrideRoute(
    this.id,
    this.hostPort,
  );

  /// 日志id
  final int id;

  /// 设备的主机地址和端口
  final String hostPort;

  static LogDetailsClientRequestOverrideRoute fromClient(
    BuildContext context,
    RequesterClient client,
  ) {
    final state =
        $LogDetailsRouteExtension._fromState(GoRouterState.of(context));
    return LogDetailsClientRequestOverrideRoute(
      state.id,
      client.hostPort.encode(),
    );
  }

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      ClientRequestOverrideScreen(
        hostPort: HostPort.decode(hostPort),
      );
}
