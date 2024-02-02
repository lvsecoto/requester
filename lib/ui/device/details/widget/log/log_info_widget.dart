import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:requester/common/progress/progress.dart';
import 'package:requester/ui/common/common.dart';
import 'package:requester/ui/device/details/provider/log.dart';

import 'log_host_port_widget.dart';

class LogInfoWidget extends StatelessWidget {
  const LogInfoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      title: const Text('网络请求日志'),
      actions: [
        Consumer(
            builder: (context, ref, _) => ProgressLoadingOutlinedButton(
                  progress: ref.watch(
                    actionResetDeviceHostPortToSelfProvider,
                  ),
                  onPressed: () async {
                    ref.read(
                      actionResetDeviceHostPortToSelfProvider.notifier,
                    )();
                  },
                  child: const Text('停止日志'),
                )),
        Consumer(
            builder: (context, ref, _) => ProgressLoadingFilledButton(
                  progress: ref.watch(
                    actionSetDeviceHostPortToSelfProvider,
                  ),
                  onPressed: () async {
                    ref.read(
                      actionSetDeviceHostPortToSelfProvider.notifier,
                    )();
                  },
                  child: const Text('绑定日志'),
                )),
      ],
      child: Consumer(
        builder: (context, ref, child) => ListTile(
          title: const Text('日志发送地址'),
          subtitle: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: Theme.of(context).textTheme.titleSmall!.fontSize! * 2,
            ),
            child: AnimatedSwitcher(
              duration: kThemeAnimationDuration,
              child: KeyedSubtree(
                key: ValueKey(ref.watch(loadDeviceLogHostPortProvider)),
                child: switch ((ref.watch(loadDeviceLogHostPortProvider))) {
                  AsyncData(:final value) => switch (value) {
                      '' => const Text('未设置'),
                      _ => const LogHostPortWidget(),
                    },
                  AsyncError() => const Text('获取失败'),
                  _ => const CircularProgressIndicator(),
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
