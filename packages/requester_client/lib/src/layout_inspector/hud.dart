part of 'layout_inspector.dart';

class _HUD extends HookWidget {
  /// 放大镜内显示的信息内容
  ///
  /// 会拾取颜色
  const _HUD({
    required this.contentKey,
    required this.offsetController,
    required this.widgetsInfoController,
  });

  /// 要拾取的颜色的子组件
  final GlobalKey contentKey;

  /// 要拾取颜色的位置
  final ValueNotifier<Offset> offsetController;

  /// 显示组件信息
  final _WidgetsInfoController widgetsInfoController;

  @override
  Widget build(BuildContext context) {
    final pickedColorController = useValueNotifier(Colors.black);

    useEffect(() {
      void onChange() {
      }
      offsetController.addListener(onChange);
      return () {
        offsetController.removeListener(onChange);
      };
    });

    return SizedBox.expand(
      child: Stack(
        children: [
          // 控制放大器的位置
          Positioned.fill(
            child: _PanController(offsetController),
          ),

          // 中间的十字
          Center(
            child: HookBuilder(
              builder: (context) => _Aim(
                color: useListenableSelector(
                  pickedColorController,
                  () => _reversedColor(pickedColorController.value),
                ),
              ),
            ),
          ),

          // 颜色拾取器
          Positioned(
            top: 8,
            right: 8,
            child: HookBuilder(
              builder: (context) => _ColorPicker(
                pickedColorController: pickedColorController,
                contentKey: contentKey,
                offset: useValueListenable(offsetController),
              ),
            ),
          ),

          // 组件信息
          Positioned(
            left: 8,
            top: 8,
            child: _WidgetInfoInspect(
              controller: widgetsInfoController,
            ),
          ),
        ],
      ),
    );
  }
}

class _Aim extends StatelessWidget {
  /// 一个十字
  const _Aim({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    final color = this.color.withOpacity(0.8);
    return SizedBox.square(
      dimension: 10,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Divider(height: 0.5, color: color),
          VerticalDivider(
            width: 0.5,
            color: color,
          ),
        ],
      ),
    );
  }
}
