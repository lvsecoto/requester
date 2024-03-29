
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'common/responsive_layout/responsive_layout.dart';

import 'route/route.dart';
export 'route/route.dart';

part 'router.g.dart';

@riverpod
// ignore: unsupported_provider_value
GoRouter router(RouterRef ref) => GoRouter(
  initialLocation: const LogListRoute().location,
  debugLogDiagnostics: true,
  routes: [
    ResponsiveLayoutShellRoute(
      routes: [
        ResponsiveLayoutNavigationDestinationRoute(
          const LogListRoute().location,
          $logListRoute,
          ResponsiveLayoutNavigationDestination(
            icon: const Icon(Icons.monitor_heart),
            title: '日志',
          ),
        ),
        ResponsiveLayoutNavigationDestinationRoute(
          const RequesterClientListRoute().location,
          $requesterClientListRoute,
          ResponsiveLayoutNavigationDestination(
            icon: const Icon(Icons.devices),
            title: '客户端',
          ),
        ),
        ResponsiveLayoutNavigationDestinationRoute(
          const SettingsRoute().location,
          $settingsRoute,
          ResponsiveLayoutNavigationDestination(
            icon: const Icon(Icons.settings),
            title: '设置',
          ),
        ),
      ],
    ),
  ],
);
