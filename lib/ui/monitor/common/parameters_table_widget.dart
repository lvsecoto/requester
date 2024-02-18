import 'package:common/common.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:requester/domain/document/document.dart';
import 'package:requester/ui/common/common.dart';

class ParametersTableValue {
  final FieldAnalysis? fieldAnalysis;
  final dynamic data;

  ParametersTableValue({
    required this.data,
    required this.fieldAnalysis,
  });
}

class ParametersTableWidget extends HookWidget {
  /// 表格
  const ParametersTableWidget({
    super.key,
    required this.data,
  });

  final Map<String, ParametersTableValue> data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (data.isEmpty) {
      return const Center(
        child: Text('没有内容'),
      );
    }
    final controller = useScrollController();
    return Scrollbar(
      controller: controller,
      child: SingleChildScrollView(
        controller: controller,
        child: Table(
          columnWidths: const {
            0: IntrinsicColumnWidth(),
            1: FlexColumnWidth(),
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
                      style: theme.textTheme.titleMedium!.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
                TableCell(
                  child: ListTile(
                    onTap: () {
                      Clipboard.setData(
                        ClipboardData(
                          text: entry.value.data.toString(),
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('内容已复制')),
                      );
                    },
                    title: AnimatedSize(
                      duration: kThemeAnimationDuration,
                      child: Wrap(
                        spacing: 16,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            entry.value.data.toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          _Document(
                            entry: entry,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class _Document extends StatelessWidget {
  const _Document({
    required this.entry,
  });

  final MapEntry<String, ParametersTableValue> entry;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final fieldAnalysis = entry.value.fieldAnalysis;
      final summary = fieldAnalysis?.summary ?? '';
      return AnimatedVisibilityWidget(
        isVisible: summary.isNotBlank,
        child: DocumentText(
          summary,
        ),
      );
    });
  }
}
