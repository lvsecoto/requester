import 'package:flutter/material.dart';
import 'package:requester/app/theme/theme.dart';

class DocumentText extends StatelessWidget {
  const DocumentText(
    this.data, {
    super.key,
  });

  final String data;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: DefaultTextStyle.of(context).style.copyWith(
        color: AppTheme.of(context).colorDocument,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
