import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.title,
    required this.child,
    required this.actions,
  });

  final Widget title;

  final Widget child;

  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 16, top: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
            child: DefaultTextStyle(
              style: Theme.of(context).textTheme.headlineSmall!,
              child: title,
            ),
          ),
          child,
          Padding(
            padding: const EdgeInsets.all(16),
            child: ButtonBar(
              children: actions,
            ),
          ),
        ],
      ),
    );
  }
}
