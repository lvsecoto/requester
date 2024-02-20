import 'package:flutter/material.dart';

/// 显示确认对话框
Future<bool> showConfirmDialog<T>(
  BuildContext context, {
  Widget? title,
  Widget? message,
}) async {
  return (await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: title,
      content: message,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('取消'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: const Text('确认'),
        ),
      ],
    ),
  )) == true;
}
