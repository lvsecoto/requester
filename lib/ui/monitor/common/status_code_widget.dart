import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:requester/common/tag_widget.dart';
import 'package:requester/domain/monitor/model.dart';

class DCStatusCodeWidget extends StatelessWidget {
  /// 返回代码
  const DCStatusCodeWidget({
    Key? key,
    required this.request,
  }) : super(key: key);

  final MonitorLogRequest request;

  @override
  Widget build(BuildContext context) {
    Widget child = const SizedBox.shrink();
    final data = request.logResponse?.data.trim();
    if (data != null && data.startsWith('{') && data.endsWith('}')) {
      final json = jsonDecode(data);
      final code = json['code'];
      if (code == 200) {
        child = const TagWidget.green(label: Text('DC: OK'));
      } else if (code == null) {
        return const SizedBox.shrink();
      } else if (code != 200) {
        child = TagWidget.red(label: Text('DC: $code'));
      }
    }
    return AnimatedSwitcher(
      duration: kThemeAnimationDuration,
      child: KeyedSubtree(
        key: ValueKey(request.logResponse == null),
        child: child,
      ),
    );
  }
}
