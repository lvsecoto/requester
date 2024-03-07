import 'package:drift/drift.dart';

import 'converter/converter.dart';

/// 日志表
class LogTable extends Table {

  /// id
  IntColumn get id => integer().autoIncrement()();

  /// 日志Id
  TextColumn get logId => text()();

  /// 日志发生时间
  IntColumn get logTime => integer().map(const DataTimeConverter())();

  /// 日志发送方
  TextColumn get logClientUid => text()();

  /// 请求方法
  TextColumn get requestMethod => text().nullable()();

  /// 请求路径
  TextColumn get requestPath => text().nullable()();

  /// 请求参数
  TextColumn get requestQueries => text().nullable().map(const KeyValueConverter())();

  /// 请求头
  TextColumn get requestHeaders => text().nullable().map(const KeyValueConverter())();

  /// 请求体
  TextColumn get requestBody => text().nullable()();

  /// 返回消耗时间
  IntColumn get responseSpentTime => integer().map(const DurationConverter()).nullable()();

  /// 状态代码（没返回时为空）
  IntColumn get responseCode => integer().nullable()();

  /// 返回Body（没返回时为空）
  TextColumn get responseBody => text().nullable()();

  /// 返回错误（没返回时为空）
  TextColumn get responseError => text().nullable()();

  /// 请求重载（没重载时为空）
  TextColumn get requestOverridden => text().nullable().map(overrideRequestConverter)();

  /// App状态日志
  IntColumn get appState => integer().nullable().map(const EnumIndexConverter(AppState.values))();

}
