import 'dart:async';
import 'dart:ui';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:requester_client/requester_client.dart';
import 'package:requester_client/rpc.dart' as rpc;
import 'package:requester_client/src/log/log.dart';
import 'package:requester_client/src/rpc/client/client_service.pb.dart';
import 'package:rxdart/rxdart.dart';

class AppStateProvider {
  final LogProvider logProvider;

  StreamSubscription? sub;

  AppStateProvider(this.logProvider) {
    sub = _logSubject
        .debounceTime(const Duration(milliseconds: 100))
        .listen((logAppState) {
      _log(logAppState);
    });
  }

  void onDispose() {
    sub?.cancel();
  }

  /// 利用subject来防止日志输出过快
  final _logSubject = PublishSubject<rpc.AppState>();

  /// 上报客户端App状态给Requester
  final stream = BehaviorSubject.seeded(rpc.ClientAppState(
    appState: AppState.APP_STATE_RESUMED,
  ));

  /// 报告App运行状态
  Future<void> reportAppState(AppLifecycleState appLifecycleState) async {
    final appState = switch (appLifecycleState) {
      AppLifecycleState.detached || AppLifecycleState.paused => null,
      AppLifecycleState.resumed => rpc.AppState.APP_STATE_RESUMED,
      AppLifecycleState.hidden => rpc.AppState.APP_STATE_HIDDE,
      AppLifecycleState.inactive => rpc.AppState.APP_STATE_INACTIVE,
    };
    if (appState != null) {
      _logSubject.add(appState);
      stream.add(rpc.ClientAppState(
        appState: appState,
      ));
    }
  }

  /// 把App状态写入日志
  void _log(rpc.AppState appState) async {
    final log = rpc.LogAppState(
      log: await logProvider.createLog(),
      appState: appState,
    );
    await logProvider.client?.logAppSate(log);
  }
}

/// 在HookWidget中观察App状态
void useAppState(RequesterClientController controller) {
  useOnAppLifecycleStateChange((_, appLifecycleState) {
    controller.appStateProvider.reportAppState(appLifecycleState);
  });
}
