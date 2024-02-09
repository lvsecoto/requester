/// 向Requester提供应用运行信息
library;

import 'package:rxdart/rxdart.dart';

typedef ClientInfo = Map<String, String>;

/// 实现接口，向Requester提供信息
class ClientInfoProvider {

  final _subject = BehaviorSubject<ClientInfo>.seeded({});

  /// 向Requester报告设备信息
  late final stream = _subject.stream;

  final Map<String, String Function(String value)> _onUpdateListeners = {};

  /// 报告[key]的值
  void set(String key, String value) {
    _subject.sink.add({
      ..._subject.value,
    }..[key] = value);
  }

  /// 当Requester让[key]的值改变，响应[update]，[update]返回更新后的值
  void on(String key, String Function(String value) update) {
    _onUpdateListeners[key] = update;
  }

  void onRequesterUpdateValue(String key, String value) {
    final newValue = _onUpdateListeners[key]?.call(value);
    if (newValue != null) {
      set(key, newValue);
    }
  }
}