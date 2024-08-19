import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:requester_client/requester_client.dart';
import 'package:rxdart/rxdart.dart';

part 'color_picker.dart';
part 'design_sketch.dart';
part 'design_sketch_actions.dart';
part 'hud.dart';
part 'magnifier.dart';
part 'widget_info/widget_info.dart';
part 'widget_info/text_info.dart';

/// 布局检查控制器
class LayoutInspectorController extends ChangeNotifier {
  ImageProvider? designSketchProvider;

  /// 对颜色[color]进行解析，显示在颜色拾取器上
  String? Function(Color color)? get decodeColor => _decodeColor;
  String? Function(Color color)? _decodeColor;

  /// 对颜色进行解析
  /// ```
  /// String? _decodeColor(Color color) {
  ///   const {
  ///     0xFFACACAC : ['主色调', '黑色']
  ///   }[color.value]?.join(',');
  /// }
  /// ```
  /// 一旦捕获到颜色`0xFFACACAC`颜色拾取器会同时显示`主色调,黑色`
  set decodeColor(String? Function(Color color)? value) {
    _decodeColor = value;
    notifyListeners();
  }

  /// 设置设计图[data]并进入检查模式
  void setDesignSketch(Uint8List data) {
    designSketchProvider = MemoryImage(data);
    notifyListeners();
  }

  /// 清除设计图并推出检查模式
  void clear() {
    designSketchProvider = null;
    notifyListeners();
  }
}

/// 布局检查
class RequesterLayoutInspector extends HookWidget {
  const RequesterLayoutInspector({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final controller = RequesterClientController.of(context)?.layoutInspector;
    if (controller == null) {
      return child;
    }
    return HookBuilder(builder: (context) {
      // 设计稿
      final designSketch = useListenableSelector(
          controller, () => controller.designSketchProvider);

      // 用于获取子组件的Content
      final contentKey = useMemoized(() => GlobalKey());

      // 控制设计稿是否可见
      final designSketchVisible = useValueNotifier(true, [designSketch]);

      // 一旦设计图有焦点，那么它就可以点击拖动，并且能用键盘控制位置
      final designSketchFocusNode = useFocusNode();

      // 设计图的位置
      final sketchOffset = useState(Offset.zero);

      // 控制放大镜是否打开
      final magnifierController = useValueNotifier(false, [designSketch]);

      // 放大镜的位置
      final magnifierOffset = useState(Offset.zero);

      // 放大镜是否正在移动
      final magnifierIsMoving = useValueNotifier(false, [designSketch]);

      // 管理组件信息
      final widgetsInfoController = useMemoized(() => _WidgetsInfoController());
      useEffect(
          () => () => widgetsInfoController.dispose(), [widgetsInfoController]);

      return Directionality(
        textDirection: TextDirection.ltr,
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            RepaintBoundary(
              key: contentKey,
              child: ValueListenableBuilder(
                valueListenable: magnifierIsMoving,
                builder: (context, isMoving, _) => AbsorbPointer(
                  absorbing: isMoving,
                  child: child,
                ),
              ),
            ),
            if (designSketch != null) ...[
              // 设计图
              _DesignSketch(
                sketch: designSketch,
                offsetController: sketchOffset,
                focusNode: designSketchFocusNode,
                isVisible: designSketchVisible,
              ),

              // 放大镜
              _Magnifier(
                visibleController: magnifierController,
                offsetController: magnifierOffset,
                isMoving: magnifierIsMoving,
                onScaleEnd: () {
                  widgetsInfoController.capture(
                      contentKey.currentContext!, magnifierOffset.value);
                },
                child: ValueListenableBuilder(
                  valueListenable: magnifierOffset,
                  builder: (context, offset, _) => _HUD(
                    contentKey: contentKey,
                    offsetController: magnifierOffset,
                    widgetsInfoController: widgetsInfoController,
                  ),
                ),
              ),

              // 通过按钮微调设计图位置
              Center(
                child: HookBuilder(
                  builder: (context) => Visibility(
                    visible: useListenableSelector(
                      designSketchFocusNode,
                      () => designSketchFocusNode.hasFocus,
                    ),
                    child: SizedBox.square(
                      dimension: 100,
                      child: _PanController(
                        sketchOffset,
                      ),
                    ),
                  ),
                ),
              ),

              Positioned(
                right: 0,
                left: 0,
                bottom: 0,
                child: _DesignSketchActions(
                  designSketchFocusNode: designSketchFocusNode,
                  magnifierController: magnifierController,
                  designSketchVisible: designSketchVisible,
                  onDone: () {
                    controller.clear();
                  },
                ),
              ),
            ],
          ],
        ),
      );
    });
  }
}
