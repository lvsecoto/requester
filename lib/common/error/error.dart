import 'dart:async';

import 'package:flutter/material.dart';

/// 运行[block]
///
/// * 如果遇到异常[UserError]，显示提示，其他的异常不会显示
/// * 所有异常都会rethrow
Future<T> handleError<T>(
    BuildContext context, FutureOr<T> Function() block) async {
  try {
    return await block();
  } on UserError catch (userError) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(userError.message),
      ),
    );
    rethrow;
  } catch (_) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('未知错误'),
      ),
    );
    rethrow;
  }
}

/// 对用户可见的错误，非程序内部错误
///
/// 比如是:
/// * 用户密码不正确
/// * 用户输入的文本格式不正确
///
/// 比如不是：
/// * 服务器返回的数据，缺少了一个字段
/// * 原本希望函数返回非空的数组，结果返回了空数组
abstract class UserError {
  /// 给用户显示的错误
  String get message;

  /// 直接创建一个UserError
  factory UserError(String message) => _BaseUserError(message);
}

class _BaseUserError implements UserError {
  /// 默认实现
  _BaseUserError(this.message);

  @override
  final String message;

  @override
  String toString() {
    return message;
  }
}

