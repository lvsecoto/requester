import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:requester/route/route.dart';
import 'package:requester/ui/log/provider/provider.dart' as provider;

import 'app_state_item_widget.dart';
import 'folded_log_item_widget.dart';
import 'request_item_widget.dart';

class LogItemWidget extends StatelessWidget {

  /// 日志条目组件，显示日志[log]内容
  ///
  /// 会根据不同的日志类型显示不同的组件
  const LogItemWidget({
    super.key,
    required this.log,
  });

  final provider.Log log;

  @override
  Widget build(BuildContext context) {
    final item = log;
    return switch (item) {
      provider.LogRequest() => _RequestItem(
          item: item,
          onTap: () async {
            LogDetailsRoute(item.id).go(context);
          },
        ),
      provider.LogAppState() => LogAppStateItemWidget(
          logAppState: item,
        ),
      provider.FoldedLogs() => FoldedLogItemWidget(
          foldedLogs: item,
        ),
    };
  }
}

class _RequestItem extends ConsumerWidget {
  const _RequestItem({
    required this.item,
    required this.onTap,
  });

  final provider.LogRequest item;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentId = LogDetailsRoute.from(GoRouterState.of(context))?.id;
    return Material(
      animationDuration: const Duration(seconds: 1),
      color: item.id == currentId
          ? Theme.of(context).colorScheme.primaryContainer
          : Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        customBorder:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: LogRequestItemWidget(
          logRequest: item,
        ),
      ),
    );
  }
}
