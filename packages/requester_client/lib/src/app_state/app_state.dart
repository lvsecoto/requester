import 'dart:ui';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:requester_client/requester_client.dart';
import 'package:requester_client/rpc.dart' as rpc;
import 'package:requester_client/src/log/log.dart';
import 'package:requester_client/src/rpc/client/client_service.pb.dart';
import 'package:rxdart/rxdart.dart';

class AppStateProvider {
  final LogProvider logProvider;

  AppStateProvider(this.logProvider);

  final stream = BehaviorSubject.seeded(rpc.ClientAppState(
    appState: AppState.APP_STATE_RESUMED,
  ));
}

void useAppState(RequesterClientController controller) {
  void log(rpc.LogAppState logAppState) {
    controller.logProvider.client?.logAppSate(logAppState);
  }

  final logSubject = useMemoized(() => PublishSubject<rpc.LogAppState>());
  useEffect(() {
    final sub = logSubject
        .debounceTime(const Duration(milliseconds: 100))
        .listen((logAppState) {
      log(logAppState);
    });
    return () {
      sub.cancel();
    };
  }, [controller]);
  useOnAppLifecycleStateChange((previous, current) async {
    final appState = switch (current) {
      AppLifecycleState.detached || AppLifecycleState.paused => null,
      AppLifecycleState.resumed => rpc.AppState.APP_STATE_RESUMED,
      AppLifecycleState.hidden => rpc.AppState.APP_STATE_HIDDE,
      AppLifecycleState.inactive => rpc.AppState.APP_STATE_INACTIVE,
    };
    if (appState != null) {
      logSubject.add(
        rpc.LogAppState(
          log: await controller.logProvider.createLog(),
          appState: appState,
        ),
      );
    }
  });
}
