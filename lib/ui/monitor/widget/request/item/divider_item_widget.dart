import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:requester/domain/monitor/model.dart';

final _dataTimeFormat = DateFormat('MM/dd hh:mm:ss');

class DividerItemWidget extends StatelessWidget {
  const DividerItemWidget({
    Key? key,
    required this.divider,
  }) : super(key: key);

  final MonitorLogDivider divider;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 24, child: Divider()),
          const SizedBox(width: 12),
          Text(
            _dataTimeFormat.format(divider.dateTime),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(width: 12),
          const SizedBox(width: 24, child: Divider()),
        ],
      ),
    );
  }
}
