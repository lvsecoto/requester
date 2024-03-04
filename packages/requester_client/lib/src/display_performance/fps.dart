import 'dart:collection';
import 'dart:ui';

import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:requester_client/requester_client.dart';

/// 监听帧率
void useFPS(RequesterClientController controller) {
  useMemoized(() {
    SchedulerBinding.instance.addTimingsCallback(
      (timings) {
        _onReportTimings(timings, controller);
      },
    );
  });
}

final _maxFrames =
    WidgetsBinding.instance.platformDispatcher.views.first.display.refreshRate;
final _frameInterval =
    Duration(microseconds: Duration.microsecondsPerSecond ~/ _maxFrames);

final _lastFrames = ListQueue<FrameTiming>(_maxFrames.toInt());

void _onReportTimings(
  List<FrameTiming> timings,
  RequesterClientController controller,
) {
  for (FrameTiming timing in timings) {
    _lastFrames.addFirst(timing);
  }

  while (_lastFrames.length >= _maxFrames) {
    _lastFrames.removeLast();
  }

  controller.displayPerformanceProvider.reportFps(_fps);
}

double get _fps {
  final lastFramesSet = <FrameTiming>[];
  for (FrameTiming timing in _lastFrames) {
    if (lastFramesSet.isEmpty) {
      lastFramesSet.add(timing);
    } else {
      var lastStart =
          lastFramesSet.last.timestampInMicroseconds(FramePhase.buildStart);
      if (lastStart - timing.timestampInMicroseconds(FramePhase.rasterFinish) >
          (_frameInterval.inMicroseconds * 2)) {
        // in different set
        break;
      }
      lastFramesSet.add(timing);
    }
  }
  final frameCount = lastFramesSet.length;
  final costCount = lastFramesSet.map((t) {
    return (t.totalSpan.inMicroseconds ~/ _frameInterval.inMicroseconds) + 1;
  }).fold(0, (a, b) => a + b);
  return frameCount * _maxFrames / costCount;
}
