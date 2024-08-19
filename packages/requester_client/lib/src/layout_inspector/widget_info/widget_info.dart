part of '../layout_inspector.dart';

class _WidgetInfoInspect extends HookWidget {
  /// 获取组件的信息
  const _WidgetInfoInspect({
    required this.controller,
  });

  /// 获取到的组件信息
  final _WidgetsInfoController controller;

  @override
  Widget build(BuildContext context) {
    final widgetInfo = useListenableSelector(
      controller,
      () => controller.value.firstOrNull,
    );
    return DefaultTextStyle(
      style: DefaultTextStyle.of(context).style.copyWith(
        color: Colors.black,
      ),
      child: switch(widgetInfo) {
        // TODO: Handle this case.
        null => const Text(''),
        // TODO: Handle this case.
        _TextWidgetInfo() => _TextInfo(widgetInfo),
      },
    );
  }
}

class _WidgetsInfoController extends ValueNotifier<List<_WidgetInfo>> {
  /// 用于管理和获取组件信息
  _WidgetsInfoController() : super(const []);

  void capture(BuildContext context, Offset pointerOffset) {
    final renderBoxes = _capture(context, pointerOffset);

    final captureWidgets = renderBoxes
        .map(
          (it) {
            if (it is RenderParagraph) {
              final style = it.text.style;
              return _TextWidgetInfo(
                style,
              );
            }
            return null;
          },
        )
        .nonNulls
        .toList();

    value = captureWidgets;
  }

  /// 通过点击测试获取组件
  static Iterable<RenderBox> _capture(
      BuildContext context, Offset pointerOffset) {
    final renderObject = context.findRenderObject() as RenderProxyBox?;

    if (renderObject == null) return [];

    final renderObjectWithoutAbsorbPointer = _bypassAbsorbPointer(renderObject);

    if (renderObjectWithoutAbsorbPointer == null) return [];

    final hitTestResult = BoxHitTestResult();
    renderObjectWithoutAbsorbPointer.hitTest(
      hitTestResult,
      position: renderObjectWithoutAbsorbPointer.globalToLocal(pointerOffset),
    );

    return hitTestResult.path
        .where((v) => v.target is RenderBox)
        .map((v) => v.target)
        .cast<RenderBox>();
  }

  static RenderBox? _bypassAbsorbPointer(RenderProxyBox renderObject) {
    RenderBox lastObject = renderObject;

    while (lastObject is! RenderAbsorbPointer) {
      lastObject = renderObject.child!;
    }

    return lastObject.child;
  }
}

sealed class _WidgetInfo {
  String get name;
}

