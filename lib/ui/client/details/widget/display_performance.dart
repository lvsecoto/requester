import 'package:common/common.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:requester/app/theme/theme.dart';
import 'package:requester/assets/assets.dart';
import 'package:requester/ui/client/details/provider/provider.dart' as provider;

class DisplayPerformance extends StatelessWidget {

  /// 显示帧率等性能信息
  const DisplayPerformance({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      color: AppTheme.of(context).surfaceContainerHigh,
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: SizedBox(
          height: 24,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: _FpsGraph(),
              ),
              Gap(8),
              Center(
                child: _CurrentFps(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CurrentFps extends ConsumerWidget {
  const _CurrentFps();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fps = provider.watchDisplayPerformanceFps(ref).$2;
    final appTheme = AppTheme.of(context);
    final color = fps
        .getStatusColor(
          colorStatusGood: appTheme.colorStatusGood,
          colorStatusRisk: appTheme.colorStatusRisk,
          colorStatusBad: appTheme.colorStatusBad,
        )
        .tone(60);
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '帧率',
          style: theme.textTheme.labelMedium,
        ),
        const Gap(8),
        AnimatedSizeAndFade(
          childKey: fps.ceil(),
          child: Text(
            fps.ceil().toString().padLeft(2, '0'),
            style: theme.textTheme.titleLarge!.copyWith(
              fontFamily: FontFamily.digital,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

const _kBarWidth = 8.0;
const _kBarPadding = 1.0;

class _FpsGraph extends HookConsumerWidget {
  const _FpsGraph();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(builder: (context, constraint) {
      final barCount = (constraint.maxWidth ~/ _kBarWidth).clamp(10, 100);
      return HookConsumer(builder: (context, ref, _) {
        final fpsHistories = useValueNotifier(<double>[]);
        final animation = useAnimationController();
        ref.listen(provider.provideDisplayPerformanceFps(ref), (_, fps) {
          animation.value = 0;
          animation.animateTo(1.0, duration: const Duration(milliseconds: 300));
          fpsHistories.value = [
            fps.$2,
            ...fpsHistories.value,
          ].takeFirst(barCount + 1);
        });
        final appTheme = AppTheme.of(context);
        return ClipRect(
          child: CustomPaint(
            painter: _FpsGraphPainter(
              fpsHistories,
              animation: animation,
              colorStatusGood: appTheme.colorStatusGood,
              colorStatusRisk: appTheme.colorStatusRisk,
              colorStatusBad: appTheme.colorStatusBad,
            ),
          ),
        );
      });
    });
  }
}

class _FpsGraphPainter extends CustomPainter {
  /// 绘制帧率图
  _FpsGraphPainter(
    // 帧率历史
    this.fpsHistories, {
    // 动画
    required this.animation,
    required this.colorStatusGood,
    required this.colorStatusRisk,
    required this.colorStatusBad,
  }) : super(
            repaint: Listenable.merge([
          fpsHistories,
          animation,
        ]));

  final ValueNotifier<List<double>> fpsHistories;

  final Animation animation;

  final Color colorStatusGood;

  final Color colorStatusRisk;

  final Color colorStatusBad;

  @override
  void paint(Canvas canvas, Size size) {
    final barHeight = size.height;
    const barWidth = _kBarWidth;
    fpsHistories.value.forEachIndexed((fps, index) {
      final fpsPercentage = fps / 60;
      canvas.drawRect(
          Rect.fromLTRB(
            size.width - barWidth * (index + 1),
            barHeight - barHeight * (fpsPercentage),
            size.width - barWidth * index - _kBarPadding,
            barHeight,
          ).translate(barWidth * (1 - animation.value), 0),
          Paint()
            ..color = fps.getStatusColor(
              colorStatusGood: colorStatusGood,
              colorStatusRisk: colorStatusRisk,
              colorStatusBad: colorStatusBad,
            ));
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is! _FpsGraphPainter ||
        colorStatusGood != oldDelegate.colorStatusGood ||
        colorStatusRisk != oldDelegate.colorStatusRisk ||
        colorStatusBad != oldDelegate.colorStatusBad ||
        fpsHistories != oldDelegate.fpsHistories;
  }
}

extension _FpsEx on double {
  Color getStatusColor({
    required Color colorStatusGood,
    required Color colorStatusRisk,
    required Color colorStatusBad,
  }) {
    return this > 60 * 0.9
        ? colorStatusGood
        : this > 60 * 0.6
            ? colorStatusRisk
            : colorStatusBad;
  }
}
