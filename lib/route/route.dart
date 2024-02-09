import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:requester/common/responsive_layout/list_details/list_details_navigation.dart';
import 'package:requester/ui/ui.dart';
import 'package:animations/animations.dart';
import 'package:requester_client/requester_client.dart';

part 'client.dart';

part 'route.g.dart';

@TypedShellRoute<MonitorRoute>(
  routes: [
    TypedGoRoute<ListDetailsEmptyRoute>(
      path: '/monitor',
    ),
    TypedGoRoute<RequestRoute>(
      path: '/monitor/:requestId',
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

class RequestRoute extends GoRouteData {
  final String requestId;

  const RequestRoute(this.requestId);

  @override
  Widget build(BuildContext context, GoRouterState state) {
    // 仅仅改变:requestId，路由不会有变化，也不会有路由动画，这里我们自己加上去
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
      child: RequestScreen(
        key: ValueKey(requestId),
        requestId: requestId,
      ),
    );
  }
}

const _settingsTypedRoute = TypedShellRoute<SettingsRoute>(routes: [
  _monitorSettingsTypedRoute,
]);

/// 设置
@_settingsTypedRoute
class SettingsRoute extends ShellRouteData {
  const SettingsRoute();

  // 默认的位置是没选择任何列表内容
  String get location => const MonitorSettingsRoute().location;

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return ListDetailsNavigation(
      navigator: navigator,
      isDetailsEmpty: state.uri.path == const ListDetailsEmptyRoute().location,
      list: const SettingsScreen(),
    );
  }
}

const _monitorSettingsTypedRoute =
    TypedGoRoute<MonitorSettingsRoute>(path: '/settings/monitor');

/// 设置监视器
class MonitorSettingsRoute extends GoRouteData {
  const MonitorSettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const MonitorSettingsScreen();
  }
}
