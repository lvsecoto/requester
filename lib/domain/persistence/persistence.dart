import 'package:persistence_annotation/persistence_annotation.dart';
import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';

part 'persistence.g.dart';

@persistenceAnnotation
class AppPersistence extends _$AppPersistence{
  static const monitorPort = 5000;

  AppPersistence(super.box);
}

@riverpod
AppPersistence appPersistence(AppPersistenceRef ref) {
  return AppPersistence(Hive.openLazyBox('app_persistence'));
}