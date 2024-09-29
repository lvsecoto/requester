import 'package:requester/ui/client/details/provider/provider.dart' as provider;
import 'package:flutter/material.dart';
import 'package:requester/ui/client/details/widget/infos/item/client_infos_item_action_widget.dart';

import 'client_infos_item_text_widget.dart';
import 'client_infos_item_switcher_widget.dart';

class ClientInfosItemWidget extends StatelessWidget {
  const ClientInfosItemWidget({
    super.key,
    required this.info,
  });

  final provider.ClientInfoValue info;

  @override
  Widget build(BuildContext context) {
    if (info.isSwitcher) {
     return ClientInfosItemSwitcherWidget(info: info);
    } else if (info.isAction) {
      return ClientInfosItemActionWidget(info: info);
    }
    return ClientInfosItemTextWidget(info: info);
  }
}
