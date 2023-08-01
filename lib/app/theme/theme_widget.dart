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
    final themeData = ThemeData(
      colorSchemeSeed: colorSeed,
      useMaterial3: true,
      snackBarTheme: const SnackBarThemeData(
          behavior: SnackBarBehavior.floating, showCloseIcon: true),
      extensions: [
        AppTheme.from(colorSeed: colorSeed),
        // LoadingStateTheme(emptyBuilder: emptyBuilder),
      ],
    );
    return themeData.copyWith(
      appBarTheme: themeData.appBarTheme.copyWith(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        foregroundColor: Colors.black,
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
