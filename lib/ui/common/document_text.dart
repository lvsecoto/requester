import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:requester/app/theme/theme.dart';

class DocumentText extends StatelessWidget {
  const DocumentText(
    this.data, {
    super.key,
    this.isError = false,
    this.isRedundant = false,
  });

  final bool isError;
  final bool isRedundant;
  final String data;

  @override
  Widget build(BuildContext context) {
    final color = isError
        ? Theme.of(context).colorScheme.error
        : AppTheme.of(context).colorDocument;
    return Material(
      color: isRedundant ? Colors.yellow.tone(95) : Colors.transparent,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          isError
              ? Icon(Icons.error, size: 16, color: color)
              : Icon(Icons.notes, size: 16, color: color),
          const Gap(8),
          Flexible(
            child: Text(
              data,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
