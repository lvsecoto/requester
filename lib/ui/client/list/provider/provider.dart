import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@riverpod
String list(ListRef ref) {
  return 'list';
}