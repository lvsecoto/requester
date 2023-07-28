import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@riverpod
String request(RequestRef ref) {
  return 'request';
}
