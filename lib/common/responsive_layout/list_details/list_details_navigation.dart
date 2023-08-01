import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dartx/dartx.dart';
import 'package:requester/app/theme/theme.dart';

import '../responsive_layout_navigation.dart';
import '../window_class.dart';

class ListDetailsNavigation extends HookConsumerWidget {
  /// 列表-详情导航响应布局
  ///
  /// 在大屏幕:
  /// 1. 列表边栏[list]显示宽度320
  /// 2. [navigator]四周有24的边距
  ///
  /// 在小屏幕:
  /// 1. 列表边栏[list]大小填充整个[ListDetailsNavigation]，
  /// 2. [navigator]大小覆盖整个[ResponsiveLayoutNavigation]
  ///
  /// 如果当前没有选择列表，传入[isDetailsEmpty]为true，这样小屏幕的时候，在[navigator]全屏的时候，
  /// [navigator]不显示，从而让被[navigator]覆盖的[list]显示出来
  ///
  /// 和go_route配合使用
  ///
  /// ```dart
  /// @TypedShellRoute<RepairRoute>(
  ///   routes: [
  ///     // 必须包含一个repair的根路由，跳转到这个路由时，子路由不不显示任何东西
  ///     TypedGoRoute<ListDetailsEmptyRoute>(
  ///       path: '/repair',
  ///     ),
  ///     // 允许从/repair/:issueId返回到/repair，这在小屏幕，从详情跳回到列表时有用
  ///     TypedGoRoute<RepairDetailsRoute>(
  ///       path: '/repair/:issueId',
  ///
  ///       /// 和issue相关的子路由
  ///       routes: [
  ///         TypedGoRoute<RepairDetailsMetaRoute>(path: 'meta'),
  ///       ],
  ///     ),
  ///   ],
  /// )
  ///
  /// class RepairRoute extends ShellRouteData {
  ///   const RepairRoute();
  ///
  ///   // 默认的位置是没选择任何列表内容
  ///   String get location => const ListDetailsEmptyRoute().location;
  ///
  ///   @override
  ///   Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
  ///     return RepairNavigation(
  ///       navigator: navigator,
  ///       isDetailsEmpty: state.location == const ListDetailsEmptyRoute().location,
  ///     );
  ///   }
  /// }
  ///
  /// class RepairDetailsRoute extends GoRouteData {
  ///   final String issueId;
  ///
  ///   const RepairDetailsRoute(this.issueId);
  ///
  ///   @override
  ///   Widget build(BuildContext context, GoRouterState state) {
  ///     // 仅仅改变:issueId，路由不会有变化，也不会有路由动画，这里我们自己加上去
  ///     return AnimatedSwitcher(
  ///       duration: kThemeAnimationDuration,
  ///       child: RepairDetailsScreen(
  ///         key: ValueKey(issueId),
  ///         issueId: issueId,
  ///       ),
  ///     );
  ///   }
  /// }
  /// ```
  const ListDetailsNavigation({
    Key? key,
    required this.list,
    required this.navigator,
    required this.isDetailsEmpty,
  }) : super(key: key);

  /// 列表边栏
  final Widget list;

  /// 传入修复问题的子路由
  final Widget navigator;

  /// 详情是否为空，为空的话，[navigator]就会不显示东西，所以这时会点击穿透处理
  final bool isDetailsEmpty;

  /// 列表在多panel情况下的宽度
  static const kListWidth = 300.0;

  /// 边距
  static const kPadding = 12.0;

  @override
  Widget build(BuildContext context, ref) {
    final size = ref.watch(windowClassNotifierProvider);
    final isCompact = size == WindowClass.compact;
    var data = MediaQuery.of(context);
    final savePadding = data.viewPadding;
    final savePaddingTop = savePadding.top;
    final savePaddingBottom = savePadding.bottom;
    // 大屏幕模式下，子窗口没有安全区域，由外窗口添加边距
    // 小屏幕吧安全区域传递到小屏幕上
    data = data
        .removePadding(
          removeTop: !isCompact,
          removeBottom: !isCompact,
        )
        .removeViewPadding(
          removeTop: !isCompact,
          removeBottom: !isCompact,
        );

    /// 详情页面
    final details = ClipRRect(
      borderRadius: isCompact ? BorderRadius.zero : BorderRadius.circular(12),
      child: IgnorePointer(
        ignoring: isDetailsEmpty,
        child: AnimatedVisibilityWidget(
          animationWidgetBuilder:
              AnimatedVisibilityWidget.fadeAnimationWidgetBuilder,
          isVisible: !isDetailsEmpty,
          child: FadeTransition(
            opacity: WindowClassNotifierWidget.animation(context),
            child: MediaQuery(
              data: data,
              child: Portal(
                  child: MediaQuery(
                data: data,
                child: navigator,
              )),
            ),
          ),
        ),
      ),
    );
    return SafeArea(
      top: !isCompact,
      right: true,
      bottom: true,
      minimum: EdgeInsets.only(
        top: Platform.isMacOS ? appWindow.titleBarHeight : 16,
        right: 16,
        bottom: 16,
      ),
      child: Material(
        color: AppTheme.of(context).surfaceContainerHigh,
        borderRadius: isCompact ? BorderRadius.zero : BorderRadius.circular(28),
        child: LayoutBuilder(builder: (context, constraint) {
          return Stack(
            children: [
              // 列表，在大屏幕宽度固定，在小屏幕宽度全屏
              Positioned(
                left: isCompact ? 16 : kPadding,
                width: isCompact ? constraint.maxWidth - 16 * 2 : kListWidth,
                top: isCompact ? 0 : savePaddingTop.coerceAtLeast(kPadding),
                bottom:
                    isCompact ? 0 : savePaddingBottom.coerceAtLeast(kPadding),
                child: AnimatedVisibilityWidget(
                  // 在小屏幕，被详情覆盖的时候，也要隐藏，在WindowClass切换动画时，列表和详情一起显示，视觉上很奇怪
                  isVisible: !(isCompact && !isDetailsEmpty),
                  animationWidgetBuilder:
                      AnimatedVisibilityWidget.fadeAnimationWidgetBuilder,
                  duration: kThemeAnimationDuration,
                  child: FadeTransition(
                    opacity: WindowClassNotifierWidget.animation(context),
                    child: MediaQuery(
                      data: data,
                      child: list,
                    ),
                  ),
                ),
              ),
              // 详情(子路由)，小屏幕填充整个页面
              Positioned(
                left: isCompact ? 0 : kListWidth + kPadding * 2,
                top: isCompact ? 0 : savePaddingTop.coerceAtLeast(kPadding),
                bottom:
                    isCompact ? 0 : savePaddingBottom.coerceAtLeast(kPadding),
                width: isCompact
                    ? constraint.maxWidth
                    : (constraint.maxWidth - kListWidth - 3 * kPadding)
                        .coerceAtLeast(
                        WindowClass.medium.maxWidth -
                            kListWidth -
                            3 * kPadding -
                            72,
                      ),
                child: PortalTarget(
                  portalCandidateLabels: const [
                    kResponsiveLayoutNavigationPortalLabel,
                  ],
                  anchor: isCompact
                      ? const Filled()
                      : const Aligned(
                          follower: Alignment.topLeft,
                          target: Alignment.topLeft,
                          widthFactor: 1.0,
                          heightFactor: 1.0,
                        ),
                  portalFollower: isCompact ? details : const SizedBox.shrink(),
                  child: !isCompact ? details : const SizedBox.shrink(),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class ListDetailsEmptyRoute extends GoRouteData {
  const ListDetailsEmptyRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SizedBox.shrink();
  }
}
