import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:requester/app/theme/theme.dart';
import 'package:requester/ui/log/provider/provider.dart' as provider;

class LogSearchBar extends StatelessWidget {
  const LogSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) => SafeArea(
        top: true,
        child: Material(
          color: AppTheme.of(context).surfaceContainerLow,
          elevation: 1,
          shape: const StadiumBorder(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: TextField(
              decoration: const InputDecoration.collapsed(
                hintText: '搜索请求',
              ),
              controller:
                  ref.watch(provider.editQueryProvider.notifier).controller,
            ),
          ),
        ),
      ),
    );
  }
}
