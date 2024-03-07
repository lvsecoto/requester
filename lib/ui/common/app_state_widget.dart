import 'package:flutter/material.dart';
import 'package:requester/app/theme/theme.dart';
import 'package:requester/common/tag_widget.dart';
import 'package:requester/domain/log/log.dart';

class AppStateWidget extends StatelessWidget {
  /// 显示App状态
  const AppStateWidget({
    super.key,
    required this.appState,
  });

  final AppState appState;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Row(
      children: [
        TagWidget(
          color: switch (appState) {
            AppState.resumed => theme.colorStatusGood,
            AppState.inactive => theme.colorStatusRisk,
            AppState.hidden => theme.colorStatusBad,
          },
          label: switch (appState) {
            AppState.resumed => const Text('运行'),
            AppState.inactive => const Text('停止'),
            AppState.hidden => const Text('隐藏'),
          },
        ),
      ],
    );
  }
}
