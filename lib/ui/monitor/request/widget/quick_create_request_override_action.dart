import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:requester/common/common.dart';
import 'package:requester/route/route.dart';
import 'package:requester/ui/client/client.dart';
import 'package:requester/ui/client/details/override/edit/edit.dart';
import 'package:requester/ui/monitor/request/provider/provider.dart'
    as provider;
import 'package:requester_client/requester_client.dart';
import 'package:requester_client/rpc.dart';
import 'package:requester_common/requester_common.dart';

class QuickCreateRequestOverrideAction extends ConsumerWidget {
  const QuickCreateRequestOverrideAction({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () async {
        final request = provider.loadLogRequest(ref);
        if (request == null) return;

        final client = await showRequestClientListDialog(context);
        if (client != null && context.mounted) {
          final override = await showOverrideRequestDialog(
            context,
            overrideRequest: OverrideRequest(
              matcher: OverrideRequestMatcher(
                path: request.requestPath,
                method: request.requestMethod,
              ),
              action: OverrideRequestAction.replace(
                responseCode: request.requestResponse?.code,
                responseBody: request.requestResponse?.body.jsonFormat(),
              ),
            ),
          );
          if (override != null) {
            await client
                .toService()
                .addRequestOverrides(override.toJson().toRpcJson().jsonValue);
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text('添加成功'),
                action: SnackBarAction(
                  label: '前往查看',
                  onPressed: () {
                    RequestViewClientRequestOverrideRoute.fromClient(client)
                        .push(context);
                  },
                ),
              ));
            }
          }
        }
      },
      icon: const Icon(Icons.flash_on),
    );
  }
}
