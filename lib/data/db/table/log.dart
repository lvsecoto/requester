import 'package:drift/drift.dart';

import 'converter/converter.dart';

/// 日志表
class LogTable extends Table {

  /// 日志id
  IntColumn get id => integer().autoIncrement()();

  /// 发生时间
  IntColumn get time => integer().nullable().map(const DataTimeConverter())();

  /// 用于识别请求
  TextColumn get requestId => text().nullable()();

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
}
