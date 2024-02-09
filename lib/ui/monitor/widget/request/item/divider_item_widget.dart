import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:requester/domain/monitor/model.dart';

final _dataTimeFormat = DateFormat('MM/dd hh:mm:ss');

class DividerItemWidget extends StatelessWidget {
  const DividerItemWidget({
    super.key,
    required this.divider,
  });

  final MonitorLogDivider divider;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 24, child: Divider()),
          const SizedBox(width: 12),
          Text(
            _dataTimeFormat.format(divider.time),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(width: 12),
          const SizedBox(width: 24, child: Divider()),
        ],
      ),
    );
  }
}
