import 'package:common_dc/common_dc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:requester/common/progress/progress.dart';
import 'package:requester/ui/device/details/provider/log.dart';

import 'log_host_port_widget.dart';

class LogInfoWidget extends StatelessWidget {
  const LogInfoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 16, top: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
            child: Text('网络请求日志',
                style: Theme.of(context).textTheme.headlineSmall),
          ),
          Consumer(
            builder: (context, ref, child) {
              final hostPort = ref.watch(loadDeviceLogHostPortProvider);
              return ListTile(
                title: const Text('日志发送地址'),
                subtitle: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight:
                        Theme.of(context).textTheme.titleSmall!.fontSize! * 2,
                  ),
                  child: DCAnimatedSizeAndFade(
                    alignment: Alignment.topLeft,
                    childKey: hostPort,
                    child: switch (hostPort) {
                      AsyncData(:final value) => switch (value) {
                          '' => const Text('未设置'),
                          _ => const LogHostPortWidget(),
                        },
                      AsyncError() => const Text('获取失败'),
                      _ => const CircularProgressIndicator(),
                    },
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ButtonBar(
              children: [
                Consumer(builder: (context, ref, _) {
                  return ProgressLoadingOutlinedButton(
                    progress: ref.watch(
                      actionResetDeviceHostPortToSelfProvider,
                    ),
                    onPressed: () async {
                      ref.read(
                        actionResetDeviceHostPortToSelfProvider.notifier,
                      )();
                    },
                    child: const Text('停止发送日志'),
                  );
                }),
                Consumer(builder: (context, ref, _) {
                  return ProgressLoadingFilledButton(
                    progress: ref.watch(
                      actionSetDeviceHostPortToSelfProvider,
                    ),
                    onPressed: () async {
                      ref.read(
                        actionSetDeviceHostPortToSelfProvider.notifier,
                      )();
                    },
                    child: const Text('发送到本设备'),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
