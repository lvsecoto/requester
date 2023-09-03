import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:requester/common/tag_widget.dart';
import 'package:requester/ui/device/details/provider/log.dart';

class LogHostPortWidget extends ConsumerWidget {
  /// 显示网络请求日志发送地址，会显示为是否是本设备地址
  const LogHostPortWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hostPort = ref.watch(loadDeviceLogHostPortProvider).valueOrNull ?? '';

    Widget child;
    if (hostPort.isBlank) {
      child = const Text('未设置');
    } else {
      child = Row(
        children: [
          Text(hostPort),
          if (isDeviceLogBound(ref))
            const TagWidget.green(
              label: Text('已绑定'),
            )
          else
            const TagWidget.grey(
              label: Text('未绑定'),
            ),
        ],
      );
    }

    return child;
  }
}
