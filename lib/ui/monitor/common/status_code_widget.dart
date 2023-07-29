import 'dart:convert';

import 'package:common_dc/common_dc.dart';
import 'package:flutter/material.dart';
import 'package:requester/common/tag_widget.dart';
import 'package:requester/domain/monitor/model.dart';

class DCStatusCodeWidget extends StatelessWidget {
  /// 返回代码
  const DCStatusCodeWidget({
    Key? key,
    required this.request,
  }) : super(key: key);

  final MonitorRequest request;

  @override
  Widget build(BuildContext context) {
    Widget child = const SizedBox.shrink();
    final data = request.logResponse?.data.trim();
    if (data != null && data.startsWith('{') && data.endsWith('}')) {
      final json = jsonDecode(data);
      final code = json['code'];
      if (code == 200) {
        child = TagWidget.green(label: Text('DC:($code)'));
      } else if (code != 200) {
        child = TagWidget.green(label: Text('DC:($code)${json['message']}'));
      }
    }
    return DCAnimatedSizeAndFade(
      child: KeyedSubtree(
        key: ValueKey(request.logResponse == null),
        child: child,
      ),
    );
  }
}
