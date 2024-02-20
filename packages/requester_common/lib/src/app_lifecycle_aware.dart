import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:synchronized/synchronized.dart';

/// 实现这个接口，感受App的周期变化
abstract class AppLifecycleAware {
  /// App继续运行
  Future<void> onAppResume();

  /// App暂停（进入后台）
  Future<void> onAppPause();
}

/// 让[appLifecycleAware]感受App的周期变化
void useAppLifecycleAware(AppLifecycleAware? appLifecycleAware) {
  final lock = useMemoized(() => Lock());
  useEffect(() {
    appLifecycleAware?.onAppResume();
    return () {
      appLifecycleAware?.onAppPause();
    };
  }, [appLifecycleAware]);
  useOnAppLifecycleStateChange((previous, current) {
    if (Platform.isMacOS || Platform.isWindows) {
      return;
    }
    if (!_isAppForeground(previous) && _isAppForeground(current)) {
      lock.synchronized(() async {
        await appLifecycleAware?.onAppResume();
      });
    } else if (_isAppForeground(previous) && !_isAppForeground(current)) {
      lock.synchronized(() async {
        await appLifecycleAware?.onAppPause();
      });
    }
  });
}

bool _isAppForeground(AppLifecycleState? appState) {
  return [AppLifecycleState.inactive, AppLifecycleState.resumed]
      .contains(appState);
}
