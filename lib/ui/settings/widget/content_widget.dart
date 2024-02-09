import 'package:flutter/material.dart';

class ContentWidget extends StatelessWidget {
  const ContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.monitor_heart),
          selectedTileColor: Theme.of(context).colorScheme.primaryContainer,
          selected: true,
          title: const Text('监视器'),
        ),
      ],
    );
  }
}
