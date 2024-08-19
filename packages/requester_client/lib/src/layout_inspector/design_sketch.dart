part of 'layout_inspector.dart';

class _DesignSketch extends HookWidget {
  /// 设计稿
  /// 可以鼠标拖动或者通过键盘移动
  const _DesignSketch({
    required this.sketch,
    required this.focusNode,
    required this.offsetController,
    required this.isVisible,
  });

  /// 设计稿
  final ImageProvider sketch;

  /// 控制焦点，只有获得焦点，才可以拖动或用鼠标控制位置
  final FocusNode focusNode;

  /// 是否可见
  final ValueNotifier<bool> isVisible;

  /// 控制它的位置
  final ValueNotifier<Offset> offsetController;

  @override
  Widget build(BuildContext context) {
    final sketchOffset = useValueListenable(offsetController);
    final hasFocus = useListenableSelector(focusNode, () => focusNode.hasFocus);

    return Positioned(
      left: sketchOffset.dx,
      top: sketchOffset.dy,
      child: KeyboardListener(
        autofocus: true,
        focusNode: focusNode,
        onKeyEvent: (event) {
          _handleMoveKeyboardEvent(event, offsetController);
        },
        child: IgnorePointer(
          ignoring: !hasFocus,
          child: GestureDetector(
            onPanUpdate: (details) {
              offsetController.value += details.delta;
            },
            child: Image(
              opacity: AlwaysStoppedAnimation(
                // 有焦点时，始终可见
                (hasFocus || useValueListenable(isVisible)) ? 0.5 : 0,
              ),
              image: sketch,
            ),
          ),
        ),
      ),
    );
  }

  // 处理键盘移动操作
  void _handleMoveKeyboardEvent(
      KeyEvent event, ValueNotifier<Offset> sketchOffset) {
    if (event is KeyDownEvent || event is KeyRepeatEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
        sketchOffset.value = sketchOffset.value.translate(0, -1);
      } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
        sketchOffset.value = sketchOffset.value.translate(0, 1);
      } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        sketchOffset.value = sketchOffset.value.translate(-1, 0);
      } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        sketchOffset.value = sketchOffset.value.translate(1, 0);
      }
    }
  }
}

class _PanController extends StatelessWidget {

  /// 显示四个方向的按钮，控制[offsetController]指示的位置
  const _PanController(this.offsetController);

  final ValueNotifier<Offset> offsetController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            onPressed: () {
              offsetController.value =
                  offsetController.value.translate(-1, 0);
            },
            icon: const Icon(Icons.keyboard_arrow_left),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: IconButton(
            onPressed: () {
              offsetController.value =
                  offsetController.value.translate(0, -1);
            },
            icon: const Icon(Icons.keyboard_arrow_up),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: () {
              offsetController.value = offsetController.value.translate(1, 0);
            },
            icon: const Icon(Icons.keyboard_arrow_right),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: IconButton(
            onPressed: () {
              offsetController.value = offsetController.value.translate(0, 1);
            },
            icon: const Icon(Icons.keyboard_arrow_down),
          ),
        ),
      ],
    );
  }
}
