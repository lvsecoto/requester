import 'dart:async';

import 'package:flutter/material.dart';

extension ShowMessageEx on BuildContext {
  /// 显示一条消息，类似于SnackBar
  Future<void> showMessage(Widget message) async {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: message,
      ),
    ).closed;
  }
}
