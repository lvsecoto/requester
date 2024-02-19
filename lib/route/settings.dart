part of 'route.dart';

class SettingsEmptyRoute extends ListDetailsEmptyRoute {
  const SettingsEmptyRoute();
}

/// 设置
@TypedShellRoute<SettingsRoute>(
  routes: [
    TypedGoRoute<SettingsEmptyRoute>(
      path: '/settingList',
      routes: [
        _monitorSettingsTypedRoute,
        _documentSettingsTypedRoute,
      ],
    ),
  ],
)
class SettingsRoute extends ShellRouteData {
  const SettingsRoute();

  // 默认的位置是没选择任何列表内容
  String get location => const SettingsEmptyRoute().location;

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return ListDetailsNavigation(
      navigator: navigator,
      isDetailsEmpty: state.uri.path == const SettingsEmptyRoute().location,
      list: const SettingsScreen(),
    );
  }
}

const _monitorSettingsTypedRoute =
    TypedGoRoute<MonitorSettingsRoute>(path: 'setting/monitor');

/// 设置监视器
class MonitorSettingsRoute extends GoRouteData {
  const MonitorSettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const MonitorSettingsScreen();
  }
}

const _documentSettingsTypedRoute =
    TypedGoRoute<DocumentSettingsRoute>(path: 'setting/document');

/// 设置文档
class DocumentSettingsRoute extends GoRouteData {
  const DocumentSettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DocumentSettingScreen();
  }
}
