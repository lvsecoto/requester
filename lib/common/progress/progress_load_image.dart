import 'dart:async';

import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import 'progress.dart';
export 'progress.dart';

/// 加载图片并报告进度
Stream<Progress> progressPrecacheImage(
    ImageProvider imageProvider, BuildContext context) async* {
  final controller = StreamController<Progress>();
  _precacheImage(
    imageProvider,
    context,
    onChunk: (event) {
      controller.add(Progress(
          current: event.cumulativeBytesLoaded,
          total: event.expectedTotalBytes ?? event.cumulativeBytesLoaded));
    },
  ).then(
    (_) {
      controller.add(const Progress.done());
      controller.close();
    },
  ).ignore();
  yield* controller.stream;
}

/// 复制[precacheImage]，增加了进度的报告，
///
/// 和原版的一样，如果**读到了相同的provider，进度是共享的**
Future<void> _precacheImage(
  ImageProvider provider,
  BuildContext context, {
  Size? size,
  ImageErrorListener? onError,
  ImageChunkListener? onChunk,
}) {
  final ImageConfiguration config =
      createLocalImageConfiguration(context, size: size);
  final Completer<void> completer = Completer<void>();
  final ImageStream stream = provider.resolve(config);
  ImageStreamListener? listener;
  listener = ImageStreamListener(
    (ImageInfo? image, bool sync) {
      if (!completer.isCompleted) {
        completer.complete();
      }
      // Give callers until at least the end of the frame to subscribe to the
      // image stream.
      // See ImageCache._liveImages
      SchedulerBinding.instance.addPostFrameCallback((Duration timeStamp) {
        stream.removeListener(listener!);
      });
    },
    onChunk: onChunk,
    onError: (Object exception, StackTrace? stackTrace) {
      if (!completer.isCompleted) {
        completer.complete();
      }
      stream.removeListener(listener!);
      if (onError != null) {
        onError(exception, stackTrace);
      } else {
        FlutterError.reportError(FlutterErrorDetails(
          context: ErrorDescription('image failed to precache'),
          library: 'image resource service',
          exception: exception,
          stack: stackTrace,
          silent: true,
        ));
      }
    },
  );
  stream.addListener(listener);
  return completer.future;
}
