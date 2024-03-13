library screenshot;

import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

/// 截图控制器
@internal
class ScreenshotController {
  final _containerKey = GlobalKey();

  Future<Uint8List> capture({
    double? pixelRatio,
    Duration delay = const Duration(milliseconds: 20),
  }) {
    // Delay is required. See Issue https://github.com/flutter/flutter/issues/22308
    return Future.delayed(delay, () async {
      final image = (await captureAsUiImage(
        delay: Duration.zero,
        pixelRatio: pixelRatio,
      ));
      final pngByteData =
          (await image.toByteData(format: ui.ImageByteFormat.png))!;
      image.dispose();

      return pngByteData.buffer.asUint8List();
    });
  }

  Future<ui.Image> captureAsUiImage({
    double? pixelRatio = 1,
    Duration delay = const Duration(milliseconds: 20),
  }) {
    //Delay is required. See Issue https://github.com/flutter/flutter/issues/22308
    return Future.delayed(delay, () async {
      var findRenderObject = _containerKey.currentContext?.findRenderObject()!;
      RenderRepaintBoundary boundary =
          findRenderObject as RenderRepaintBoundary;
      BuildContext? context = _containerKey.currentContext;
      if (pixelRatio == null) {
        if (context != null) {
          pixelRatio = pixelRatio ?? MediaQuery.of(context).devicePixelRatio;
        }
      }
      ui.Image image = await boundary.toImage(pixelRatio: pixelRatio ?? 1);
      return image;
    });
  }
}

@internal
class Screenshot extends StatelessWidget {

  /// 套在组件[child]上，对齐截图
  ///
  /// 调用[controller.capture()]截图
  const Screenshot({
    super.key,
    required this.child,
    required this.controller,
  });

  final ScreenshotController controller;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: controller._containerKey,
      child: child,
    );
  }
}
