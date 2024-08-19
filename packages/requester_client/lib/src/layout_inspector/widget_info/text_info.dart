part of '../layout_inspector.dart';

class _TextInfo extends StatelessWidget {
  const _TextInfo(this.info);

  final _TextWidgetInfo info;

  @override
  Widget build(BuildContext context) {
    final textStyle = DefaultTextStyle.of(context).style;
    final fontSize = info.textStyle?.fontSize?.toInt() ?? 0;
    final fontHeight = ((info.textStyle?.height ?? 1.0) * fontSize).toInt();
    final letterSpacing = info.textStyle?.letterSpacing;
    final color = info.textStyle?.color;
    final fontWeight = info.textStyle?.fontWeight?.value ?? 0;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(2),
          elevation: 2,
          child: DefaultTextStyle(
            style: textStyle.copyWith(fontSize: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(width: 2),
                const Icon(Icons.format_size, size: 10),
                const SizedBox(width: 2),
                Text('$fontSize/$fontHeight:$letterSpacing'),
                const SizedBox(width: 4),
                const Icon(Icons.format_bold, size: 10),
                Text(fontWeight.toString()),
                const SizedBox(width: 2),
              ],
            ),
          ),
        ),
        const SizedBox(height: 4),
        if (color != null) _ColorInfo(color: color),
      ],
    );
  }
}

class _TextWidgetInfo extends _WidgetInfo {
  @override
  String get name => '文本';

  _TextWidgetInfo(this.textStyle);

  final TextStyle? textStyle;
}
