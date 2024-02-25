import 'package:drift/drift.dart';

/// 客户端历史表，每当扫描到后，都会更新
class ClientTable extends Table {

  /// id
  IntColumn get id => integer().autoIncrement()();

  /// 标识客户端
  TextColumn get clientUid => text().unique()();

  /// 用户标识客户端
  TextColumn get clientId => text()();

  /// 应用名称
  TextColumn get appName => text()();

  /// 应用版本
  TextColumn get appVersion => text()();

  /// 对Requester Host
  TextColumn get host => text()();

  /// 对Requester 端口
  IntColumn get port => integer()();
}
