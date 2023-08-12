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
    return Row(
      children: [
        const Divider(),
        Text(_dataTimeFormat.format(divider.dateTime)),
        const Divider(),
      ],
    );
  }
}
