import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:requester/common/responsive_layout/responsive_column.dart';
import 'package:requester/ui/client/details/provider/provider.dart' as provider;
import 'package:requester/ui/client/details/widget/log_info_widget.dart';

import 'client_id_widget.dart';
import 'client_infos_widget.dart';

class ContentWidget extends HookConsumerWidget {
  const ContentWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScaffoldMessenger(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('客户端'),
          actions: [
            IconButton(
              onPressed: () {
                provider.actionRefresh(ref);
              },
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
        body: const SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 12, right: 16),
                  child: ResponsiveColumn(
                    children: [
                      ClientIdWidget(),
                      LogInfoWidget(),
                    ],
                  ),
                ),
                ClientInfosWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
