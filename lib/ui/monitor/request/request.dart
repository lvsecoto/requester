import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:requester/ui/monitor/request/provider/provider.dart';

import 'widget/content_widget.dart';

class RequestScreen extends ConsumerWidget {
  const RequestScreen({
    super.key,
    required this.id,
  });

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
      parent: ProviderScope.containerOf(context),
      overrides: [
        requestLogIdProvider.overrideWithValue(id)
      ],
      child: const ContentWidget(),
    );
  }
}
