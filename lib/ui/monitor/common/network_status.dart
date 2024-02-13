import 'dart:ui';

import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:requester/domain/log/log.dart';

class NetworkStatus extends StatelessWidget {
  /// 网络状态
  const NetworkStatus({
    super.key,
    required this.logRequest,
  });

  final LogRequest logRequest;

  @override
  Widget build(BuildContext context) {
    Widget child;
    String durationStr(Duration duration) {
      if (duration >= const Duration(seconds: 1)) {
        return '${(duration.inSeconds + duration.inMilliseconds / 1000).toStringAsFixed(2)}s';
      } else {
        return '${duration.inMilliseconds}ms';
      }
    }

    final response = logRequest.requestResponse;
    if (response?.body != null) {
      final duration = response!.spentTime;
      child = DefaultTextStyle(
        style: Theme.of(context)
            .textTheme
            .labelMedium!
            .copyWith(color: Colors.green),
        child: Row(
          children: [
            const _Circle(
              color: Colors.green,
            ),
            const SizedBox(width: 4),
            Text(durationStr(duration)),
          ],
        ),
      );
    } else if (response?.error != null) {
      final duration = response!.spentTime;
      child = Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const _Circle(
            color: Colors.red,
          ),
          const SizedBox(width: 4),
          Text(
            '${response.error.toString()}(${durationStr(duration)})',
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Colors.red,
                ),
          )
        ],
      );
    } else {
      child = Row(
        children: [
          const SizedBox.square(
            dimension: 8,
            child: CircularProgressIndicator(
              strokeWidth: 1,
            ),
          ),
          const SizedBox(width: 4),
          HookBuilder(builder: (context) {
            final loadSpentTime =
                useState(DateTime.now().difference(logRequest.time));
            useInterval(() {
              loadSpentTime.value = DateTime.now().difference(logRequest.time);
            }, const Duration(seconds: 1));
            return Text(
              '${loadSpentTime.value.inSeconds}s',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(fontFeatures: [
                const FontFeature.tabularFigures(),
              ]),
            );
          })
        ],
      );
    }
    return AnimatedSizeAndFade(
      childKey: response,
      child: child,
    );
  }
}

class _Circle extends StatelessWidget {
  const _Circle({
    required this.color,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: ShapeDecoration(
        shape: const CircleBorder(),
        color: color,
      ),
    );
  }
}
