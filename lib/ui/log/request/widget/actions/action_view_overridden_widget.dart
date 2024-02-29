import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:requester/app/theme/theme.dart';
import 'package:requester/ui/client/client.dart';
import 'package:requester/ui/client/details/override/edit/edit.dart';
import 'package:requester/ui/log/request/provider/provider.dart' as provider;
import 'package:requester_client/rpc.dart';

class ActionViewOverriddenWidget extends ConsumerWidget {
  /// 显示，并可以打开重载对话框（如果有重载）
  const ActionViewOverriddenWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final overridden = provider.watchLogRequest(ref)?.requestOverridden;
    return AnimatedVisibilityWidget(
      isVisible: overridden != null,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          minimumSize: Size.zero,
          foregroundColor: AppTheme.of(context).colorOverridden,
          side: BorderSide(
            color: AppTheme.of(context).colorOverridden,
          ),
        ),
        onPressed: overridden != null
            ? () async {
                final client = provider.getLogRequesterClient(ref) ??
                    await showRequestClientListDialog(context);
                if (client != null && context.mounted) {
                  final overrideRequest = await showOverrideRequestDialog(
                    context,
                    overrideRequest: overridden,
                    title: const Text('查看重载规则'),
                    actionTitle: const Text('新增规则'),
                  );
                  if (overrideRequest != null) {
                    client.toService().addRequestOverrides(
                          overrideRequest.toJson().toRpcJson().jsonValue,
                        );
                  }
                }
              }
            : null,
        icon: const Icon(Icons.flash_on, size: 14),
        label: const Padding(
          padding: EdgeInsets.symmetric(vertical: 4),
          child: Text('已重载'),
        ),
      ),
    );
  }
}
