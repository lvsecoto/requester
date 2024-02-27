import 'dart:convert';

import 'package:drift/drift.dart';
export 'requester.dart';

class DataTimeConverter extends TypeConverter<DateTime, int?> {

  /// 日期时间转换
  const DataTimeConverter();

  @override
  DateTime fromSql(int? fromDb) {
    if (fromDb == null) return DateTime.fromMillisecondsSinceEpoch(0);
    return DateTime.fromMillisecondsSinceEpoch(fromDb);
  }

  @override
  int toSql(DateTime value) {
    return value.millisecondsSinceEpoch;
  }
}

class DurationConverter extends TypeConverter<Duration, int?> {

  /// 持续时间转
  const DurationConverter();

  @override
  Duration fromSql(int? fromDb) {
    if (fromDb == null) return const Duration();
    return Duration(milliseconds: fromDb);
  }

  @override
  int toSql(Duration value) {
    return value.inMilliseconds;
  }
}

class KeyValueConverter extends TypeConverter<Map<String, String>, String?> {

  /// 持续时间转
  const KeyValueConverter();

  @override
  Map<String, String> fromSql(String? fromDb) {
    if (fromDb == null) return const {};
    try {
      return (jsonDecode(fromDb) as Map).cast();
    } catch (e) {
      return const {};
    }
  }

  @override
  String toSql(Map<String, String> value) {
    return jsonEncode(value);
  }
}
