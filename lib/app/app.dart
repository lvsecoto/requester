import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:common/common.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:requester/common/responsive_layout/responsive_layout.dart';
import 'package:requester/domain/monitor/monitor.dart';
import 'package:requester/log/log.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../router.dart';
import 'theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

part 'app.g.dart';

/// app的Key，给外部有个全局的Context
///
/// see [appContext]
@riverpod
GlobalKey _appKey(_AppKeyRef ref) {
  return GlobalKey();
}

/// 给外部有个app全局的Context
@riverpod
BuildContext appContext(AppContextRef ref) {
  return ref.watch(_appKeyProvider).currentState!.context;
}

class App extends StatelessWidget {
  /// App入口
  /// 设置主题等等
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonAppWrapper(
      child: ThemeWidget(
        builder: (context, themeData, child) => LogServiceControllerWidget(
          child: HookConsumer(
            builder: (context, ref, child) {
              ref.listen(monitorProvider, (previous, next) { });
              return MaterialApp.router(
                key: ref.watch(_appKeyProvider),
                routerConfig: ref.watch(routerProvider),
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale.fromSubtags(
                    languageCode: 'zh',
                    scriptCode: 'Hans',
                  ),
                ],
                theme: themeData.copyWith(),
                builder: (context, child) => Stack(
                  children: [
                    MediaQuery(
                      data: MediaQuery.of(context).copyWith(
                        padding: Platform.isMacOS || Platform.isWindows
                            ? EdgeInsets.only(top: appWindow.titleBarHeight)
                            : null,
                      ),
                      child: WindowClassNotifierWidget(
                        child: child!,
                      ),
                    ),
                    // 顶部，用来拖动窗口，覆盖在整个界面之上
                    if (Platform.isMacOS ||
                        Platform.isWindows ||
                        Platform.isLinux)
                      Positioned.fill(
                        bottom: null,
                        child: WindowTitleBarBox(child: MoveWindow()),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
