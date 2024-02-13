import 'package:common/common.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:requester/domain/log/log.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@riverpod
class EditQuery extends _$EditQuery with TextEditControllerNotifier {
  @override
  String build() {
    return super.onBuild();
  }
}

LogListProvider watchLogProvider(WidgetRef ref) {
  return ref.watch(logManagerProvider).providerLogList;
}