import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:requester/app/theme/theme.dart';
import 'package:requester_client/requester_client.dart';

class ClientWidget extends StatelessWidget {
  /// 显示设备信息
  const ClientWidget({
    super.key,
    required this.requesterClient,
  });

  final RequesterClient requesterClient;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              requesterClient.appName,
              style: textTheme.bodyLarge!.bold,
            ),
            const Gap(8),
            Text(
              requesterClient.appVersion,
              style: textTheme.bodySmall!.mediumEmphasis,
            ),
          ],
        ),
        Row(
          children: [
            Text(
              '${requesterClient.clientUid}   ${requesterClient.hostPort.encode()}',
              style: textTheme.labelSmall!.copyWith(
                height: 0.8,
              ).disabled,
            ),
          ],
        ),
      ],
    );
  }
}
