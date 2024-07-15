import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:requester/common/common.dart';
import 'package:requester/ui/client/details/provider/provider.dart' as provider;
import 'package:requester/ui/common/common.dart';

class ClientInfosItemSwitcherWidget extends ConsumerWidget {
  /// 开类的客户端信息
  const ClientInfosItemSwitcherWidget({
    super.key,
    required this.info,
  });

  final provider.ClientInfoValue info;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchListTile(
      title: Text(info.name),
      value: info.data == true.toString(),
      onChanged: (value) {
        provider.actionUpdateClientInfoEntry(
          ref,
          key: info.key,
          value: value.toString(),
        );
      },
    );
  }
}
