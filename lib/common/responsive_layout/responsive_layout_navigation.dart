import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:requester/app/theme/theme.dart';

import 'window_class.dart';

import 'list_details/list_details.dart';
export 'list_details/list_details.dart';

const kResponsiveLayoutNavigationPortalLabel =
    PortalLabel('kResponsiveLayoutNavigationPortalLabel');

/// [ResponsiveLayoutNavigation]直接作为[ShellRoute]来使用
///
/// [routes]设置几个子页面的路由和按钮图标文字
class ResponsiveLayoutShellRoute extends ShellRoute {
  ResponsiveLayoutShellRoute({
    super.observers,
    required List<ResponsiveLayoutNavigationDestinationRoute> routes,
    Widget? floatingActionButton,
  }) : super(
          routes: routes.map((it) => it.route).toList(),
          builder: (context, state, child) {
            var matchedIndex = 0;
            final path = state.uri.path;

            matchedIndex = routes.indexWhere((it) {
              return path.startsWith(it.basePath);
            });
            return ResponsiveLayoutNavigation(
              currentIndex: matchedIndex,
              navigator: child,
              destinations: routes.map((it) => it.destination).toList(),
              floatingActionButton: floatingActionButton,
              onChangeIndex: (index) {
                context.go(routes[index].basePath);
              },
            );
          },
        );
}

class ResponsiveLayoutNavigationDestinationRoute {
  /// 每一个路由，以及它的入口按钮配置
  ResponsiveLayoutNavigationDestinationRoute(
      this.basePath, this.route, this.destination);

  final String basePath;
  final RouteBase route;
  final ResponsiveLayoutNavigationDestination destination;
}

class ResponsiveLayoutNavigationDestination {
  final Widget icon;
  final String title;

  /// 定义在导航栏的图标和标题
  ResponsiveLayoutNavigationDestination({
    required this.icon,
    required this.title,
  });
}

class ResponsiveLayoutNavigation extends HookConsumerWidget {
  /// 响应布局的根布局，包含了导航栏，在不同的[WindowClass]下，导航栏的显示位置不一样
  ///
  /// [destinations]定义各个子页面，子页面的显示和切换在[navigator]完成
  ///
  /// 对于桌面版本应用，顶部还有个可以拖动窗体的组件，覆盖在整个布局，包括[navigator]上
  ///
  /// 更多响应布局子页面
  /// * [ListDetailsNavigation]
  const ResponsiveLayoutNavigation({
    super.key,
    required this.currentIndex,
    required this.navigator,
    required this.destinations,
    required this.onChangeIndex,
    this.floatingActionButton,
  });

  /// 当前索引位置
  final int currentIndex;

  /// 子路由Widget
  final Widget navigator;

  /// 子路由入口
  final List<ResponsiveLayoutNavigationDestination> destinations;

  /// FAB，适配不同的布局
  final Widget? floatingActionButton;

  /// 当入口改变时
  final ValueChanged<int> onChangeIndex;

  @override
  Widget build(BuildContext context, ref) {
    final isCompact =
        ref.watch(windowClassNotifierProvider) == WindowClass.compact;
    final containerColor = AppTheme.of(context).surfaceContainerHighest;
    var data = MediaQuery.of(context);
    if (Platform.isMacOS) {
      data = data.copyWith(
        padding: data.padding.copyWith(
          top: appWindow.titleBarHeight,
        ),
      );
    }
    useMemoized(() {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: containerColor,
        ),
      );
    });
    return MediaQuery(
      data: data,
      child: WindowClassNotifierWidget(
        child: Portal(
          labels: const [
            kResponsiveLayoutNavigationPortalLabel,
          ],
          child: Scaffold(
            backgroundColor: containerColor,
            floatingActionButton: isCompact ? floatingActionButton : null,
            bottomNavigationBar: AnimatedVisibilityWidget(
              isVisible: isCompact,
              animationWidgetBuilder:
                  AnimatedVisibilityWidget.verticalAnimationWidgetBuilder,
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: NavigationBar(
                  elevation: 0,
                  onDestinationSelected: (index) {
                    onChangeIndex(index);
                  },
                  labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                  backgroundColor: containerColor,
                  destinations: _buildBottomNavLinks(),
                  selectedIndex: currentIndex,
                ),
              ),
            ),
            body: Row(
              children: [
                AnimatedVisibilityWidget(
                  isVisible: !isCompact,
                  child: NavigationRail(
                    destinations: _buildRailNavLinks(),
                    backgroundColor: containerColor,
                    groupAlignment: 0,
                    labelType: NavigationRailLabelType.all,
                    selectedIndex: currentIndex,
                    onDestinationSelected: onChangeIndex,
                    leading: isCompact ? null : floatingActionButton,
                  ),
                ),
                Expanded(
                  child: Container(child: navigator),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<NavigationRailDestination> _buildRailNavLinks() {
    return destinations
        .map((it) => NavigationRailDestination(
              icon: it.icon,
              label: Text(it.title),
            ))
        .toList();
  }

  List<Widget> _buildBottomNavLinks() {
    return destinations
        .map((it) => NavigationDestination(
              icon: it.icon,
              label: it.title,
            ))
        .toList();
  }
}
