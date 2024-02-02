import 'dart:ui';

import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:requester/domain/monitor/model.dart';

class NetworkStatus extends StatelessWidget {
  /// 网络状态
  const NetworkStatus({
    Key? key,
    required this.request,
  }) : super(key: key);

  final MonitorLogRequest request;

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

    if (request.logResponse != null) {
      final duration =
          request.logResponse!.time.difference(request.logRequest.time);
      child = DefaultTextStyle(
        style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.green),
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
    } else if (request.logException != null) {
      final duration =
          request.logException!.time.difference(request.logRequest.time);
      child = Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const _Circle(
            color: Colors.red,
          ),
          const SizedBox(width: 4),
          Text(
            '${request.logException!.type.toString().split('.').last}(${durationStr(duration)})',
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
                useState(DateTime.now().difference(request.time));
            useInterval(() {
              loadSpentTime.value = DateTime.now().difference(request.time);
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
    return child;
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
