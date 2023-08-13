import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'theme.dart';

class ThemeWidget extends StatelessWidget {
  /// 封装了主题的处理
  const ThemeWidget({
    super.key,
    required this.builder,
  });

  final ValueWidgetBuilder<ThemeData> builder;

  @override
  Widget build(BuildContext context) {
    return builder(context, _buildTheme(Colors.blue), null);
  }

  /// 生成以[primaryColor]为主色调的颜色主题
  ThemeData _buildTheme(Color primaryColor) {
    const colorSeed = Colors.lightBlue;
    var appTheme = AppTheme.from(colorSeed: colorSeed);
    final colorTheme = ColorScheme.fromSeed(
      seedColor: colorSeed,
      background: appTheme.surfaceContainerLow,
    );
    final themeData = ThemeData.from(
      colorScheme: colorTheme,
      useMaterial3: true,
    );
    return themeData.copyWith(
      snackBarTheme: const SnackBarThemeData(
          behavior: SnackBarBehavior.floating, showCloseIcon: true),
      extensions: [
        appTheme,
        // LoadingStateTheme(emptyBuilder: emptyBuilder),
      ],
      colorScheme: themeData.colorScheme.copyWith(
        background: appTheme.surfaceContainerLow,
      ),
      platform: Platform.isWindows
          // Windows向macOS靠拢
          ? TargetPlatform.macOS
          : Platform.isAndroid
              // android向iOS靠拢
              ? TargetPlatform.iOS
              : null,
      appBarTheme: themeData.appBarTheme.copyWith(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        foregroundColor: Colors.black,
        backgroundColor: appTheme.surfaceContainerLow,
        iconTheme: themeData.iconTheme.copyWith(
          color: Colors.black,
        ),
      ),
      hoverColor: themeData.colorScheme.onSurface.withOpacity(0.08),
      focusColor: themeData.colorScheme.onSurface.withOpacity(0.12),
      splashColor: themeData.colorScheme.onSurface.withOpacity(0.12),
    );
  }
}
