import 'package:common_dc/common_dc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:requester/ui/monitor/common/data_widget.dart';
import 'package:requester/ui/monitor/common/status_code_widget.dart';
import 'package:requester/ui/monitor/request/provider/provider.dart';

import 'panel_widget.dart';

class ResponsePanel extends ConsumerWidget {
  const ResponsePanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final request = loadMonitorRequest(ref);
    final exception = request?.logException;
    final response = request?.logResponse;

    Widget title;

    if (exception != null) {
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

    if (exception != null) {
      child = Center(
        child: Text(
          exception.type.toString(),
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.red,
              ),
        ),
      );
    } else if (response != null) {
      child = DataWidget(
        data: response.data,
      );
    } else {
      child = const SizedBox.shrink();
    }

    final state = (response, exception);
    return PanelWidget(
      margin: const EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 16),
      title: DCAnimatedSizeAndFade(
        childKey: [state],
        alignment: Alignment.centerLeft,
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
      child: DCAnimatedSizeAndFade(
        childKey: [state],
        child: SizedBox(
          width: double.maxFinite,
          height: double.maxFinite,
          child: child,
        ),
      ),
    );
  }
}
