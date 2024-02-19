import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic tryJsonDecode(String? source) {
  try {
    return jsonDecode(source!);
  } catch (e) {
    return null;
  }
}

Future<void> copyToClipBoard(BuildContext context, String text) async {
  await Clipboard.setData(ClipboardData(text: text));
  if (context.mounted) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('内容已复制')));
  }
}

extension JsonFormattedEx on String {
  static const _encoder = JsonEncoder.withIndent('   ');

  String jsonFormat() {
    final json = tryJsonDecode(this);
    if (json == null) {
      return this;
    } else {
      return _encoder.convert(json);
    }
  }
}
