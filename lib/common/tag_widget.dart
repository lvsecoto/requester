import 'package:flutter/material.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

class TagWidget extends StatelessWidget {
  /// 标签，文字是深色[color]，背景是浅色[color]
  const TagWidget({
    super.key,
    this.icon,
    required this.label,
    required this.color,
    this.disable = false,
  });

  const TagWidget.red({
    super.key,
    this.icon,
    required this.label,
    this.disable = false,
  }) : color = Colors.red;

  const TagWidget.green({
    super.key,
    this.icon,
    required this.label,
    this.disable = false,
  }) : color = Colors.green;

  const TagWidget.blue({
    super.key,
    this.icon,
    required this.label,
    this.disable = false,
  }) : color = Colors.blue;

  const TagWidget.cyan({
    super.key,
    this.icon,
    required this.label,
    this.disable = false,
  }) : color = Colors.cyan;

  const TagWidget.yellow({
    super.key,
    this.icon,
    required this.label,
    this.disable = false,
  }) : color = Colors.yellow;

  const TagWidget.purple({
    super.key,
    this.icon,
    required this.label,
    this.disable = false,
  }) : color = Colors.purpleAccent;

  const TagWidget.grey({
    super.key,
    this.icon,
    required this.label,
    this.disable = true,
  }) : color = Colors.transparent;

  /// 标签颜色
  final Color color;

  /// 不可用状态，会变成灰度
  final bool disable;

  /// 图标
  final Widget? icon;

  /// 文字
  final Widget label;

  @override
  Widget build(BuildContext context) {
    final labelTextStyle = Theme.of(context).textTheme.labelLarge;
    final iconSize = labelTextStyle!.fontSize;

    final tonalPalette = TonalPalette.of(
      Cam16.fromInt(color.value).hue,
      disable ? 0 : 48,
    );

    return Material(
      borderRadius: BorderRadius.circular(8),
      color: Color(tonalPalette.get(95)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              IconTheme(
                data: Theme.of(context).iconTheme.copyWith(
                      color: Color(tonalPalette.get(40)),
                      size: iconSize,
                    ),
                child: icon!,
              ),
              const SizedBox(width: 4),
            ],
            DefaultTextStyle(
              style: labelTextStyle.copyWith(
                color: Color(tonalPalette.get(40)),
              ),
              child: label,
            ),
          ],
        ),
      ),
    );
  }
}
