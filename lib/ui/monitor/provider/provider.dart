import 'package:common/common.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:requester/domain/log/log.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@riverpod
class EditQuery extends _$EditQuery with TextEditControllerNotifier {
  @override
  String build() {
    final subject = BehaviorSubject.seeded('');
    ref.listenSelf((previous, next) {
      subject.add(next);
    });
    final sub = subject
        .throttleTime(
      const Duration(milliseconds: 500),
      trailing: true,
    )
        .listen((query) {
      ref.read(currentFilterProvider.notifier).state =
          ref.read(currentFilterProvider).copyWith(
                query: query,
              );
    });
    ref.onDispose(() {
      sub.cancel();
    });
    return super.onBuild();
  }
}

@riverpod
class CurrentFilter extends _$CurrentFilter {
  @override
  LogFilter build() {
    return const LogFilter();
  }
}

@riverpod
class WatchLogProvider extends _$WatchLogProvider {
  @override
  LogListProvider build() {
    final filter = ref.watch(currentFilterProvider);
    var provider = stateOrNull;
    List<Log> currentLogs = const [];
    if (provider != null) {
      currentLogs = ref.read(provider).data;
    }
    return ref.watch(logManagerProvider).providerLogList(filter.copyWith(
      byData: currentLogs,
    ));
  }
}

Future<void> actionClearLog(WidgetRef ref) async {
  return ref.read(logManagerProvider).clear();
}
