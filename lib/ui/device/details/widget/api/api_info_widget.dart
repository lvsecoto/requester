import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:requester/common/tag_widget.dart';
import 'package:requester/ui/common/card_widget.dart';
import 'package:requester/ui/device/details/provider/api.dart';

class APIInfoWidget extends StatelessWidget {
  const APIInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      title: const Text('API信息'),
      actions: [
        OutlinedButton(
          onPressed: () {},
          child: const Text('恢复默认'),
        ),
        FilledButton.tonal(
          onPressed: () {},
          child: const Text('修改主机'),
        ),
      ],
      child: ListTile(
        title: const Text('重载主机地址'),
        subtitle: Consumer(
          builder: (context, ref, child) {
            final state = ref.watch(loadDeviceApiHostOverrideProvider);
            return Row(
              children: [
                Text(state.valueOrNull ?? ''),
                switch (state) {
                  AsyncData(:final value) => AnimatedSwitcher(
                      duration: kThemeAnimationDuration,
                      child: value.isNullOrBlank
                          ? const TagWidget.grey(
                              label: Text('默认'),
                            )
                          : const TagWidget.red(
                              label: Text('重载中'),
                            ),
                    ),
                  AsyncLoading() => const SizedBox.square(
                      dimension: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                      ),
                    ),
                  AsyncError(:final error) => Expanded(
                      child: Text(
                        error.toString(),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Theme.of(context).colorScheme.error,
                            ),
                      ),
                    ),
                  _ => const SizedBox.shrink(),
                },
              ],
            );
          },
        ),
      ),
    );
  }
}
