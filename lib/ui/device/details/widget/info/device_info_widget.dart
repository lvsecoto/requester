import 'package:common_dc/common_dc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:requester/ui/device/details/provider/provider.dart';

class DeviceInfoWidget extends ConsumerWidget {
  const DeviceInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final info = ref.watch(loadDeviceInfoProvider).valueOrNull;
    return DCCollapsedGroupWidget(
      max: 3,
      children: [
        _InfoTile(
          title: const Text('请求Token'),
          valueText: info?.token ?? '',
        ),
        _InfoTile(
          title: const Text('设备uid'),
          valueText: info?.deviceUID ?? '',
        ),
        ...(info?.meta ?? {}).entries.map(
              (entry) => _InfoTile(
                title: Text(entry.key),
                valueText: entry.value,
              ),
            ),
      ],
      builder: (context, children, _) {
        return Column(
          children: children,
        );
      },
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.title,
    required this.valueText,
  });

  /// 标题
  final Widget title;

  /// 值
  final String? valueText;

  @override
  Widget build(BuildContext context) {
    final valueText = this.valueText;
    return ListTile(
      title: title,
      subtitle:
          Text(valueText ?? '', maxLines: 2, overflow: TextOverflow.ellipsis),
      onTap: valueText == null
          ? null
          : () {
              Clipboard.setData(
                ClipboardData(text: valueText),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('已复制')),
              );
            },
    );
  }
}
