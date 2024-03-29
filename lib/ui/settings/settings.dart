import 'package:flutter/material.dart';

import 'widget/widget.dart';

export 'monitor/monitor.dart';
export 'document/document.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ContentWidget();
  }
}
