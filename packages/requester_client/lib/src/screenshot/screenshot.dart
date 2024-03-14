import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:requester_client/requester_client.dart';

import 'capture.dart';

@internal
class RequesterScreenshotWidget extends HookWidget {

  /// 实现截屏
  const RequesterScreenshotWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final screenshotController = useMemoized(() => ScreenshotController());
    useMemoized(() {
      RequesterClientController.of(context)!.onTakeScreenshot =
          screenshotController.capture;
    });
    return Screenshot(
      controller: screenshotController,
      child: child,
    );
  }
}
