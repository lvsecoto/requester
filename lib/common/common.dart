import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

export 'widget/widget.dart';
export 'provider/provider.dart';
export 'paging_data/paging_data.dart';
export 'hook/hook.dart';
export 'loading/loading.dart';

Future<void> copyToClipBoard(BuildContext context, String text) async {
  await Clipboard.setData(ClipboardData(text: text));
  if (context.mounted) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('内容已复制')));
  }
}
