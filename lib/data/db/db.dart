import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'table/table.dart';

part 'db.g.dart';

@riverpod
AppDatabase appDataBase(AppDataBaseRef ref) {
  ref.keepAlive();
  final db = AppDatabase();
  ref.onDispose(() async {
    await db.close();
  });
  return db;
}

@DriftDatabase(tables: [
  LogTable,
  ClientTable,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

QueryExecutor _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}