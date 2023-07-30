import 'package:common_dc/common_dc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:requester/app/theme/theme.dart';
import 'package:requester/ui/monitor/common/method_widget.dart';
import 'package:requester/ui/monitor/request/provider/provider.dart';
import 'package:requester/ui/monitor/request/widget/request_panel.dart';
import 'package:requester/ui/monitor/request/widget/response_panel.dart';

class ContentWidget extends ConsumerWidget {
  const ContentWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final request = loadMonitorRequest(ref);
    return Scaffold(
      backgroundColor: AppTheme.of(context).surfaceContainer,
      appBar: AppBar(
        title: DCAnimatedSizeAndFade(
          childKey: request == null,
          alignment: Alignment.centerLeft,
          child: request == null
              ? const SizedBox.shrink()
              : Row(
                  children: [
                    MethodWidget(request: request),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(request.logRequest.uri.toString()),
                    ),
                  ],
                ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: RequestPanel(),
          ),
          Expanded(
            child: ResponsePanel(),
          ),
        ],
      ),
    );
  }
}
