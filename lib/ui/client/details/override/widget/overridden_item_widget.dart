import 'package:common/common.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:requester/ui/client/details/override/edit/edit.dart';
import 'package:requester/ui/client/details/override/provider/provider.dart'
    as provider;
import 'package:requester/ui/common/common.dart';
import 'package:requester_client/requester_client.dart';

class OverriddenItemWidget extends ConsumerWidget {
  const OverriddenItemWidget({
    super.key,
    required this.overrideRequest,
  });

  final OverrideRequest overrideRequest;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = overrideRequest.remark.isNotBlank
        ? overrideRequest.remark
        : overrideRequest.matcher.path;
    return SwitchListTile(
      value: overrideRequest.isEnabled,
      onChanged: (value) {
        provider.actionUpdateOverrideRequest(
          ref,
          overrideRequest.copyWith(
            isEnabled: value,
          ),
        );
      },
      controlAffinity: ListTileControlAffinity.leading,
      title: AnimatedSizeAndFade(
        alignment: Alignment.centerLeft,
        childKey: title,
        child: Text(title),
      ),
      secondary: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final override = await showOverrideRequestDialog(context,
                  overrideRequest: overrideRequest);
              if (override != null) {
                provider.actionUpdateOverrideRequest(ref, override);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () async {
              final confirmed =
                  await showConfirmDialog(context, title: const Text('确认删除?'));
              if (confirmed) {
                provider.actionRemoveOverrideRequest(ref, overrideRequest);
              }
            },
          ),
        ],
      ),
    );
  }
}
