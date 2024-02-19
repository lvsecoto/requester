import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:requester/router.dart';
import 'package:requester_client/requester_client.dart';

class ClientItemWidget extends StatelessWidget {
  const ClientItemWidget({
    super.key,
    required this.client,
    required this.onTap,
  });

  final RequesterClient client;

  final ValueChanged<RequesterClient> onTap;

  @override
  Widget build(BuildContext context) {
    final hostPort = client.hostPort;
    final title = '${client.clientId.trim()} 的 ${client.appName} ';
    final subtitle = 'V${client.appVersion}\n'
        '${hostPort.host}:${hostPort.port}';
    return ListTile(
      leading: const Icon(Icons.phone_android_sharp),
      title: Builder(builder: (context) {
        final style = DefaultTextStyle.of(context).style;
        return EasyRichText(
          title,
          patternList: [
            EasyRichTextPattern(
              targetString: client.clientId,
              style: style.copyWith(
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        );
      }),
      subtitle: Text(subtitle),
      onTap: () {
        onTap(client);
      },
    );
  }
}
