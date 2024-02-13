
import 'package:flutter/material.dart';
import 'package:requester/common/tag_widget.dart';
import 'package:requester/domain/log/log.dart';

class DCStatusCodeWidget extends StatelessWidget {
  /// 返回状态码
  const DCStatusCodeWidget({
    super.key,
    required this.request,
  });

  final LogRequest request;

  @override
  Widget build(BuildContext context) {
    Widget child = const SizedBox.shrink();
    final code = request.requestResponse?.code;
    if (code == null) {
      child = const SizedBox.shrink();
    } else if (code == 200) {
      child = const TagWidget.green(label: Text('200'));
    } else if (code != 200) {
      child = TagWidget.red(label: Text('$code'));
    }
    return AnimatedSwitcher(
      duration: kThemeAnimationDuration,
      child: KeyedSubtree(
        key: ValueKey(code),
        child: child,
      ),
    );
  }
}
