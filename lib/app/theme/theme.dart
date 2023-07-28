import 'dart:math';

import 'package:flutter/material.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

export 'theme_widget.dart';

class AppTheme extends ThemeExtension<AppTheme> {
  // 补充主题，包括M3主题
  const AppTheme({
    required this.surfaceContainerLowest,
    required this.surface,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
    required this.priorityHeight,
    required this.priorityLow,
  });

  factory AppTheme.from({required Color colorSeed}) {
    final palette = CorePalette.of(colorSeed.value);

    // 业务颜色
    final primaryCam = Cam16.fromInt(colorSeed.value);
    final priorityHeight = TonalPalette.of(
      Cam16.fromInt(Colors.red.value).hue,
      max(48, primaryCam.chroma),
    ).get(40);
    final priorityLow = palette.neutral.get(40);

    return AppTheme(
      surfaceContainerLowest: Color(palette.neutral.get(100)),
      surface: Color(palette.neutral.get(98)),
      surfaceContainerLow: Color(palette.neutral.get(96)),
      surfaceContainer: Color(palette.neutral.get(94)),
      surfaceContainerHigh: Color(palette.neutral.get(92)),
      surfaceContainerHighest: Color(palette.neutral.get(90)),
      priorityHeight: Color(priorityHeight),
      priorityLow: Color(priorityLow),
    );
  }

  final Color surfaceContainerLowest;
  final Color surface;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;

  final Color priorityHeight;
  final Color priorityLow;

  static AppTheme of(BuildContext context) =>
      Theme.of(context).extension<AppTheme>()!;

  @override
  ThemeExtension<AppTheme> copyWith() => AppTheme(
        surfaceContainerLowest: surfaceContainerLowest,
        surface: surface,
        surfaceContainerLow: surfaceContainerLow,
        surfaceContainer: surfaceContainer,
        surfaceContainerHigh: surfaceContainerHigh,
        surfaceContainerHighest: surfaceContainerHighest,
        priorityHeight: priorityHeight,
        priorityLow: priorityLow,
      );

  @override
  ThemeExtension<AppTheme> lerp(ThemeExtension<AppTheme>? other, double t) {
    if (other is! AppTheme) {
      return this;
    }
    return AppTheme(
      surfaceContainerLowest:
          Color.lerp(surfaceContainerLowest, other.surfaceContainerLowest, t) ??
              Colors.transparent,
      surface: Color.lerp(surface, other.surface, t) ?? Colors.transparent,
      surfaceContainerLow:
          Color.lerp(surfaceContainerLow, other.surfaceContainerLow, t) ??
              Colors.transparent,
      surfaceContainer:
          Color.lerp(surfaceContainer, other.surfaceContainer, t) ??
              Colors.transparent,
      surfaceContainerHigh:
          Color.lerp(surfaceContainerHigh, other.surfaceContainerHigh, t) ??
              Colors.transparent,
      surfaceContainerHighest: Color.lerp(
              surfaceContainerHighest, other.surfaceContainerHighest, t) ??
          Colors.transparent,
      priorityHeight: Color.lerp(priorityHeight, other.priorityHeight, t) ??
          Colors.transparent,
      priorityLow:
          Color.lerp(priorityLow, other.priorityLow, t) ?? Colors.transparent,
    );
  }
}

extension TextStyleEx on TextStyle {
  TextStyle get highEmphasis => copyWith(
        color: color!.withOpacity(0.87),
      );

  TextStyle get mediumEmphasis => copyWith(
        color: color!.withOpacity(0.60),
      );

  TextStyle get disabled => copyWith(
        color: color!.withOpacity(0.38),
      );
}
