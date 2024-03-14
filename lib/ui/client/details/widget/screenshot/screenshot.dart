import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:requester/ui/client/details/provider/provider.dart' as provider;

import 'screenshot_editor.dart';

class TakeScreenshotAction extends ConsumerWidget {
  const TakeScreenshotAction({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () async {
        final image = await provider.actionTakeScreenshot(ref);
        if (context.mounted) {
          showScreenshotEditor(context, image);
        }
      },
      icon: const Icon(Icons.camera_alt),
      tooltip: '截屏',
    );
  }
}
