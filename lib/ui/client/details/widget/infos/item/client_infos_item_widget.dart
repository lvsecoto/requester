import 'package:requester/ui/client/details/provider/provider.dart' as provider;
import 'package:flutter/material.dart';
import 'package:requester/ui/client/details/widget/infos/item/client_infos_item_text_widget.dart';

class ClientInfosItemWidget extends StatelessWidget {
  const ClientInfosItemWidget({
    super.key,
    required this.info,
  });

  final provider.ClientInfoValue info;

  @override
  Widget build(BuildContext context) {
    return ClientInfosItemTextWidget(info: info);
  }
}
