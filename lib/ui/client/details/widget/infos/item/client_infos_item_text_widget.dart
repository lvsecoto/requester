import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:requester/common/common.dart';
import 'package:requester/ui/client/details/provider/provider.dart' as provider;
import 'package:requester/ui/common/common.dart';

class ClientInfosItemTextWidget extends ConsumerWidget {
  /// 文本类的客户端信息
  const ClientInfosItemTextWidget({
    super.key,
    required this.info,
  });

  final provider.ClientInfoValue info;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      onTap: () {
        copyToClipBoard(context, info.data);
      },
      title: Text(info.name),
      subtitle: Text(info.data),
      trailing: IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () async {
          final value = await showInputDialog(
            context,
            title: Text('输入${info.name}'),
            text: info.data,
          );
          if (value != null) {
            provider.actionUpdateClientInfoEntry(
              ref,
              key: info.key,
              value: value,
            );
          }
        },
      ),
    );
  }
}
