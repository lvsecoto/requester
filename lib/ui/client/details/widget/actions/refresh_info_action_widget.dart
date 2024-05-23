import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:requester/ui/client/details/provider/provider.dart' as provider;

class RefreshInfoActionWidget extends ConsumerWidget {

  /// 刷新信息按钮
  const RefreshInfoActionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () {
        provider.actionRefresh(ref);
      },
      icon: const Icon(Icons.refresh),
    );
  }
}

