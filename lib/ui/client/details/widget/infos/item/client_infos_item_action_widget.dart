import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:requester/ui/client/details/provider/provider.dart' as provider;
import 'package:requester_client/rpc.dart';

class ClientInfosItemActionWidget extends ConsumerWidget {
  /// 操作类客户端信息
  const ClientInfosItemActionWidget({
    super.key,
    required this.info,
  });

  final provider.ClientInfoValue info;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(info.name),
      trailing: IconButton(
        onPressed: () {
          provider.actionUpdateClientInfoEntry(
            ref,
            key: info.key,
            value: DateTime.now().millisecond.toString(),
            type: ClientInfoType.action,
          );
        },
        icon: const Icon(Icons.play_arrow),
      ),
    );
  }
}
