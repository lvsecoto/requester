part of 'layout_inspector.dart';

class _Magnifier extends HookWidget {
  /// 放大镜
  const _Magnifier({
    required this.visibleController,
    required this.offsetController,
    required this.isMoving,
    required this.onScaleEnd,
    required this.child,
  });

  /// 可见性控制
  final ValueNotifier<bool> visibleController;

  /// 镜子是否在移动
  final ValueNotifier<bool> isMoving;

  /// 镜子的位置
  final ValueNotifier<Offset> offsetController;

  /// 这个组件显示在放大镜内部
  final Widget child;

  /// 手势结束后调
  final VoidCallback onScaleEnd;

  // 最小倍率
  static const kMinScale = 1.0;

  // 中间倍率
  static const kMiddleScale = 2.0;

  // 最大倍率
  static const kMaxScale = 4.0;

  // 镜子的大小
  static const kSize = Size(250, 140);

  @override
  Widget build(BuildContext context) {
    final isVisible =
        useListenableSelector(visibleController, () => visibleController.value);

    // 放大镜的位置
    final offset = useValueListenable(
      offsetController,
    );

    // 放大的倍率
    final scaleState = useState(1.0);

    // 之前的放大倍率，用来判断用户放大意图
    final prevScale = usePrevious(scaleState.value);

    return Visibility(
      visible: isVisible,
      child: Positioned(
        left: offset.dx - kSize.width ~/ 2,
        top: offset.dy - kSize.height ~/2,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onDoubleTap: () {
            _onDoubleTap(scaleState, prevScale);
          },
          onScaleStart: (details) {
            isMoving.value = true;
          },
          onScaleEnd: (details) {
            onScaleEnd();
            isMoving.value = false;
          },
          onScaleUpdate: (details) {
            _onScaleOffsetChanged(
              details,
              offsetController,
              scaleState,
            );
          },
          child: RawMagnifier(
            decoration: MagnifierDecoration(
              shadows: kElevationToShadow[2],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: const BorderSide(color: Colors.grey, width: 1),
              ),
            ),
            size: kSize,
            magnificationScale: scaleState.value,
            child: child,
          ),
        ),
      ),
    );
  }

  /// 处理手势对放大位置和倍率变化
  void _onScaleOffsetChanged(
    ScaleUpdateDetails details,
    ValueNotifier<Offset> offset,
    ValueNotifier<double> scale,
  ) {
    offset.value += details.focalPointDelta;
    scale.value = (scale.value * details.scale).clamp(kMinScale, kMaxScale);
  }

  // 双击时，处理倍率
  void _onDoubleTap(ValueNotifier<double> scale, double? prevScale) {
    final currentScale = scale.value;
    if (currentScale == kMaxScale || currentScale == kMinScale) {
      // 在两个极点时，都是回到中间倍数
      scale.value = kMiddleScale;
    } else {
      if (currentScale > (prevScale ?? kMinScale)) {
        // 用户是放大的意图
        if (currentScale < kMiddleScale) {
          scale.value = kMiddleScale;
        } else {
          scale.value = kMaxScale;
        }
      } else {
        // 用户是缩小的意图
        if (currentScale > kMiddleScale) {
          scale.value = kMiddleScale;
        } else {
          scale.value = kMinScale;
        }
      }
    }
  }
}
