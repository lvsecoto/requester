part of 'layout_inspector.dart';

class _ColorPicker extends HookWidget {
  /// 颜色拾取器
  const _ColorPicker({
    required this.contentKey,
    required this.pickedColorController,
    required this.offset,
  });

  /// 要拾取的颜色的子组件
  final GlobalKey contentKey;

  /// 要拾取颜色的位置
  final Offset offset;

  /// 选择的颜色控制器
  final ValueNotifier<Color> pickedColorController;

  @override
  Widget build(BuildContext context) {
    // 设置即时拾取[offset]的颜色
    _setupColorPickJob(pickedColorController);

    // 拾取到的颜色
    final pickedColor = useValueListenable(pickedColorController);

    return _ColorInfo(
      color: pickedColor,
    );
  }

  /// 设置颜色拾取操作
  void _setupColorPickJob(ValueNotifier<Color> pickedColor) {
    useEffect(() {
      // 这里做个处理防止过快的拾取颜色
      // 因为每次拾取都要截图
      final box = (contentKey.currentContext?.findRenderObject()
          as RenderRepaintBoundary?);
      final subject = PublishSubject();
      final sub = subject
          .throttleTime(const Duration(milliseconds: 500))
          .listen((event) {
        if (box != null) {
          () async {
            final color = await _getPixelFromImage(
              await box.toImage(pixelRatio: 1),
              offset,
            );
            pickedColor.value = color;
          }();
        }
      });

      var isActivity = true;
      void update(Duration time) {
        if (isActivity) {
          subject.add(time);
          WidgetsBinding.instance.addPostFrameCallback(update);
        }
      }

      WidgetsBinding.instance.addPostFrameCallback(update);
      return () {
        isActivity = false;
        sub.cancel();
      };
    });
  }

  /// 从图片中间获取像素
  Future<Color> _getPixelFromImage(ui.Image image, Offset offset) async {
    final byteData = (await image.toByteData())!;

    final dx = offset.dx.toInt().clamp(0, image.width - 1);
    final dy = offset.dy.toInt().clamp(0, image.height - 1);

    final index = ((dy * image.width + dx) * 4);

    final r = byteData.getUint8(index);
    final g = byteData.getUint8(index + 1);
    final b = byteData.getUint8(index + 2);
    final a = byteData.getUint8(index + 3);

    return Color.fromARGB(a, r, g, b);
  }
}

class _ColorInfo extends HookWidget {
  // 颜色信息组件
  const _ColorInfo({
    required this.color,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {

    final controller = RequesterClientController.of(context)!.layoutInspector;
    final decodeColor = useListenableSelector(controller, () => controller.decodeColor);

    // 反色
    Color invertedColor = _reversedColor(color);

    // 解析到的颜色
    final decodedColor = decodeColor?.call(color);

    final primaryTextStyle = DefaultTextStyle.of(context).style.copyWith(
      fontSize: 12,
      color: invertedColor,
      fontFeatures: [const FontFeature.tabularFigures()],
    );

    return DecoratedBox(
      decoration: ShapeDecoration(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: BorderSide(color: invertedColor),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '#${color.value.toRadixString(16).substring(2).padLeft(6, '0').toUpperCase()}',
              style: primaryTextStyle,
            ),
            if(decodedColor != null) Text(
              decodedColor,
              style: primaryTextStyle.copyWith(
                fontSize: primaryTextStyle.fontSize! * 0.8,
                color: invertedColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Color _reversedColor(Color pickedColor) {
  final k = ((pickedColor.red * 299) +
          (pickedColor.blue * 587) +
          (pickedColor.blue * 114)) /
      1000;
  final invertedColor = k > 128 ? Colors.black : Colors.white;
  return invertedColor;
}
