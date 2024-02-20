import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> copyToClipBoard(BuildContext context, String text) async {
  await Clipboard.setData(ClipboardData(text: text));
  if (context.mounted) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('内容已复制')));
  }
}
