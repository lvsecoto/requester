import 'package:common_dc/common_dc.dart';
import 'package:flutter/material.dart';
import 'package:requester/domain/monitor/model.dart';

class NetworkStatus extends StatelessWidget {
  /// 网络状态
  const NetworkStatus({
    Key? key,
    required this.request,
  }) : super(key: key);

  final MonitorRequest request;

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (request.logResponse != null) {
      child = const _Circle(
        color: Colors.green,
      );
    } else if (request.logException != null) {
      child = Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const _Circle(
            color: Colors.red,
          ),
          const SizedBox(width: 4),
          Text(
            request.logException!.type.toString().split('.').last,
            style: Theme.of(context).textTheme.labelMedium!.withColor(
                  Colors.red,
                ),
          )
        ],
      );
    } else {
      child = _Circle(
        color: Colors.grey[300]!,
      );
    }
    return DCAnimatedSizeAndFade(
      alignment: Alignment.centerLeft,
      childKey: request.logResponse != null || request.logException != null,
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
