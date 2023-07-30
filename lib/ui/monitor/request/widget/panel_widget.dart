import 'package:common_dc/common_dc.dart';
import 'package:flutter/material.dart';

class PanelWidget extends StatelessWidget {
  const PanelWidget({
    super.key,
    required this.title,
    this.margin,
    required this.child,
  });

  final Widget title;

  final Widget child;

  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: margin,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DefaultTextStyle(
              style: Theme.of(context).textTheme.headlineSmall!.bold,
              child: title,
            ),
            const SizedBox(height: 8),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
