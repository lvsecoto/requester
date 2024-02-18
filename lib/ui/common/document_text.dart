import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:requester/app/theme/theme.dart';

class DocumentText extends StatelessWidget {
  const DocumentText(
    this.data, {
    super.key,
  });

  final String data;

  @override
  Widget build(BuildContext context) {
    final color = AppTheme.of(context).colorDocument;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.notes, size: 16, color: color),
        const Gap(8),
        Text(
          data,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
