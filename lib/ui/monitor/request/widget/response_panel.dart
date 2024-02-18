import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:requester/ui/monitor/common/common.dart';
import 'package:requester/ui/monitor/request/provider/provider.dart';

import 'panel_widget.dart';

class ResponsePanel extends ConsumerWidget {
  const ResponsePanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final request = loadLogRequest(ref);
    final error = request?.requestResponse?.error;
    final response = request?.requestResponse;

    Widget title;

    final hasError = error.isNotNullOrBlank;
    if (hasError) {
      title = const Text('响应失败');
    } else if (response != null) {
      title = const Text('响应');
    } else {
      title = const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('等待响应'),
          SizedBox(width: 8),
          SizedBox.square(
            dimension: 16,
            child: CircularProgressIndicator(),
          ),
        ],
      );
    }

    Widget child;

    if (hasError) {
      child = Center(
        child: Text(
          error!,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.red,
              ),
        ),
      );
    } else if (response != null) {
      child = DataWidget(
        data: loadLogResponseBody(ref),
      );
    } else {
      child = const SizedBox.shrink();
    }

    final state = (response, error);
    return PanelWidget(
      margin: const EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 16),
      title: AnimatedSwitcher(
        duration: kThemeAnimationDuration,
        child: KeyedSubtree(
          key: ValueKey(state),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              title,
              if (request != null) ...[
                const SizedBox(width: 12),
                DCStatusCodeWidget(request: request),
              ]
            ],
          ),
        ),
      ),
      child: AnimatedSwitcher(
        duration: kThemeAnimationDuration,
        child: KeyedSubtree(
          key: ValueKey(state),
          child: SizedBox(
            width: double.maxFinite,
            height: double.maxFinite,
            child: child,
          ),
        ),
      ),
    );
  }
}
