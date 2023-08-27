import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:requester/ui/device/details/provider/provider.dart';
import 'package:requester/ui/device/details/widget/info/device_info_widget.dart';

class ContentWidget extends ConsumerWidget {
  const ContentWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(deviceClientProvider, (_, __) {});
    return ScaffoldMessenger(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('设备详情'),
          actions: [
            IconButton(
              onPressed: () {
                ref.invalidate(loadDeviceInfoProvider);
              },
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
        body: AutoDisposeProviderLoadingStateWidget.multiple(
          futureProvider: [
            loadDeviceInfoProvider,
          ],
          child: const SizedBox(
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  DeviceInfoWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
