import 'dart:io';

import 'package:dartx/dartx_io.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:requester/ui/client/details/provider/provider.dart' as provider;
import 'package:requester/ui/common/handle_status/handle_loading.dart';
import 'package:requester_client/rpc.dart' as rpc;

class MoreActionWidget extends ConsumerWidget {
  /// 更多操作
  const MoreActionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton(
      position: PopupMenuPosition.under,
      itemBuilder: (context) => [
        PopupMenuItem(
          child: const Text('安装应用'),
          onTap: () async {
            await _actionInstallApp(ref);
          },
        ),
        PopupMenuItem(
          child: const Text('上传设计图'),
          onTap: () async {
            await _actionUploadDesignSketch(ref);
          },
        ),
      ],
    );
  }

  /// 操作：安装应用
  Future<void> _actionInstallApp(WidgetRef ref) async {
    final context = ref.context;

    const typeGroup = XTypeGroup(
      label: 'apk',
      extensions: <String>['apk'],
    );
    final file = await openFile(
      acceptedTypeGroups: [typeGroup],
    );

    if (file != null && context.mounted) {
      final bundleFile = File(file.path);
      final service = ref.read(provider.clientServiceProvider)!;

      handleLoadingState(
        context,
        () => service.install(
          bundleFile.openRead().map((data) {
            return rpc.InstallBundle(data: data);
          }),
        ),
      );
    }
  }

  /// 操作：上传设计图
  Future<void> _actionUploadDesignSketch(WidgetRef ref) async {
    final context = ref.context;

    const typeGroup = XTypeGroup(
      label: '图片',
      extensions: <String>['png'],
    );
    final file = await openFile(
      acceptedTypeGroups: [typeGroup],
    );

    if (file != null && context.mounted) {
      final bundleFile = File(file.path);
      final service = ref.read(provider.clientServiceProvider)!;

      handleLoadingState(
        context,
        () async => service.uploadDesignSketch(rpc.DesignSketch(
          name: bundleFile.name,
          data: (await bundleFile.readAsBytes()).toList(),
        )),
      );
    }
  }
}
