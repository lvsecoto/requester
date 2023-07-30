import 'package:common_dc/common_dc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ParametersTableWidget extends StatelessWidget {
  /// 表格
  const ParametersTableWidget({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (data.isEmpty) {
      return const Center(
        child: Text('没有内容'),
      );
    }
    return Table(
      columnWidths: const {
        0: IntrinsicColumnWidth(),
      },
      children: [
        ...data.entries.map(
          (entry) => TableRow(children: [
            TableCell(
              child: ListTile(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: entry.key));
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('内容已复制')));
                },
                title: Text(
                  entry.key,
                  style: theme.textTheme.titleMedium!.withColor(
                    theme.colorScheme.primary,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ),
            TableCell(
              child: ListTile(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: entry.value));
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('内容已复制')));
                },
                title: Text(
                  entry.value.toString(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
