import 'package:flutter/material.dart';

class LoadingStateTheme extends ThemeExtension<LoadingStateTheme> {
  /// 加载状态主题，全局配置
  LoadingStateTheme({required this.emptyBuilder});

  /// 空视图，没有内容时显示
  final WidgetBuilder? emptyBuilder;

  @override
  ThemeExtension<LoadingStateTheme> copyWith() => LoadingStateTheme(
        emptyBuilder: emptyBuilder,
      );

  @override
  ThemeExtension<LoadingStateTheme> lerp(
      covariant ThemeExtension<LoadingStateTheme>? other, double t) {
    if (other is! LoadingStateTheme) {
      return this;
    }
    return LoadingStateTheme(
      emptyBuilder: other.emptyBuilder,
    );
  }
}
