import 'dart:convert';

import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:requester/app/theme/theme.dart';
import 'package:requester/route/route.dart';
import 'package:requester/ui/device/list/provider/service_discovery.dart';

class ContentWidget extends HookConsumerWidget {
  const ContentWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final services = ref.watch(foundServicesProvider);
    return ServiceDiscoveryController(
      child: Scaffold(
        backgroundColor: AppTheme.of(context).surfaceContainer,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('设备列表'),
        ),
        body: CustomScrollView(
          slivers: [
            DiffSliverAnimatedList(
              items: services,
              itemBuilder: (context, device) {
                final host = utf8.decode(device.txt?['host']?.toList() ?? []);
                return ListTile(
                leading: const Icon(Icons.phone_android_sharp),
                title: Text(device.name ?? ''),
                subtitle: Text(host),
                onTap: () {
                  DeviceDetailsRoute('$host:50051').go(context);
                },
              );
              },
            ),
          ],
        ),
      ),
    );
  }
}
