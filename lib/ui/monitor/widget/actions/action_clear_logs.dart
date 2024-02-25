import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:requester/ui/monitor/provider/provider.dart' as provider;

class ActionClearLogs extends ConsumerWidget {
  const ActionClearLogs({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton.outlined(
      onPressed: () async {
        final confirmed = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('清除所有记录'),
                  content: const Text('请确认清除操作'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('取消'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: const Text('确认清除'),
                    ),
                  ],
                ));

        if (confirmed == true) {
          provider.actionClearLog(ref);
        }
      },
      icon: const Icon(Icons.cleaning_services),
      tooltip: '清除',
    );
  }
}
