import 'package:flutter/material.dart';

Future<T?> showOptionsDialog<T>(
  BuildContext context, {
  required List<T> options,
  Widget Function(BuildContext context, T item, Function(T option) onTap)?
      optionBuilder,
}) {
  return showDialog<T>(
    context: context,
    builder: (dialogContext) => SimpleDialog(
      children: [
        ...options.map((option) =>
            optionBuilder?.call(context, option, (option) {
              Navigator.of(dialogContext).pop(option);
            }) ??
            ListTile(
              title: Text(option.toString()),
              onTap: () {
                Navigator.of(dialogContext).pop(option);
              },
            )),
      ],
    ),
  );
}
