import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:requester/ui/monitor/request/provider/provider.dart';

import 'widget/content_widget.dart';

class RequestScreen extends ConsumerWidget {
  const RequestScreen({
    super.key,
    required this.requestId,
  });

  final String requestId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
      parent: ProviderScope.containerOf(context),
      overrides: [
        requestIdProvider.overrideWithValue(requestId)
      ],
      child: const ContentWidget(),
    );
  }
}
