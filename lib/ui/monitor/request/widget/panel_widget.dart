import 'package:common_dc/common_dc.dart';
import 'package:flutter/material.dart';
import 'package:requester/app/theme/theme.dart';

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
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DefaultTextStyle(
            style: Theme.of(context).textTheme.headlineSmall!.bold,
            child: title,
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Material(
              color: AppTheme.of(context).surface,
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(16),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
