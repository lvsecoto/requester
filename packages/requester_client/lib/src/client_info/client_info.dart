/// 向Requester提供应用运行信息
library;

import 'package:flutter/animation.dart';
import 'package:requester_client/src/rpc/rpc.dart' as rpc;
import 'package:rxdart/rxdart.dart';

typedef ClientInfoType = rpc.ClientInfoType;
typedef ClientInfos = Map<String, (String, ClientInfoType)>;

/// 实现接口，向Requester提供信息
class ClientInfoProvider {
  final _subject = BehaviorSubject<ClientInfos>.seeded({});

  /// 向Requester报告设备信息
  late final stream = _subject.stream;

  final Map<String, String Function(String value, rpc.ClientInfoType type)> _onUpdateListeners = {};

  /// 客户端向Requester报告[key]的值，可以指定key的类型
  void set(
    String key,
    String value, {
    ClientInfoType type = ClientInfoType.text,
  }) {
    _subject.sink.add({
      ..._subject.value,
    }..[key] = (value, type));
  }

  /// 注册key相关数据的回调
  ///
  /// 当Requester让[key]的值改变，client响应[update]，[update]返回更新后的值
  void on(String key, String Function(String value, rpc.ClientInfoType type) update) {
    _onUpdateListeners[key] = update;
  }

  void onRequesterUpdateValue(String key, String value, rpc.ClientInfoType type) {
    final newValue = _onUpdateListeners[key]?.call(value, type);
    if (newValue != null) {
      set(key, newValue, type: type);
    }
  }
}

extension ClientInfoProviderInfoSwitcherEx on ClientInfoProvider {
  /// 客户端向Requester报告[key]的值，可以指定key的类型
  void setSwitcher(String key, bool isOn) {
    set(key, isOn.toString(), type: ClientInfoType.switcher);
  }

  /// 注册key相关数据的回调
  ///
  /// 当Requester让[key]的值改变，client响应[update]，[update]返回更新后的值
  void onSwitcher(String key, bool Function(bool isOn) update) {
    on(key, (value, type) {
      return update(value == true.toString()).toString();
    });
  }
}

extension ClientInfoProviderInfoActionEx on ClientInfoProvider {
  /// 客户端注册一个操作
  void onAction(String key, VoidCallback onTap) {
    set(key, '', type: ClientInfoType.action);
    on(key, (value, type) {
      onTap();
      return value;
    });
  }
}
