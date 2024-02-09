import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:requester/ui/client/details/provider/provider.dart' as provider;
import 'package:requester_common/requester_common.dart';

class ContentWidget extends HookConsumerWidget {
  const ContentWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScaffoldMessenger(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('设备信息'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
        body: const SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _Infos(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Infos extends ConsumerWidget {
  const _Infos({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final infos =
        ref.watch(provider.observeClientInfoProvider).valueOrNull?.entries ??
            [];
    print(ref.watch(provider.observeClientInfoProvider).error);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...infos.map(
          (info) => ListTile(
            title: Text(info.key),
            subtitle: Text(info.value),
          ),
        ),
      ],
    );
  }
}
