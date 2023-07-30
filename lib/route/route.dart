import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:requester/common/responsive_layout/list_details/list_details_navigation.dart';
import 'package:requester/ui/ui.dart';
import 'package:animations/animations.dart';

part 'route.g.dart';

@TypedShellRoute<MonitorRoute>(
  routes: [
    // 必须包含一个repair的根路由，跳转到这个路由时，子路由不不显示任何东西
    TypedGoRoute<ListDetailsEmptyRoute>(
      path: '/monitor',
    ),
    // 允许从/repair/:issueId返回到/repair，这在小屏幕，从详情跳回到列表时有用
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
      isDetailsEmpty: state.location == const ListDetailsEmptyRoute().location,
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

const _settingsTypedRoute = TypedGoRoute<SettingsRoute>(
  path: '/settings',
);

/// 设置
@_settingsTypedRoute
class SettingsRoute extends GoRouteData {
  const SettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const Placeholder();
}
