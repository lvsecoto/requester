import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:requester/ui/monitor/request/provider/provider.dart';

import 'widget/content_widget.dart';

class RequestScreen extends StatelessWidget {
  const RequestScreen({
    super.key,
    required this.requestId,
  });

  final String requestId;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        requestIdProvider.overrideWithValue(requestId)
      ],
      child: const ContentWidget(),
    );
  }
}
