import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@riverpod
String monitor(MonitorRef ref) {
  return 'monitor';
}
