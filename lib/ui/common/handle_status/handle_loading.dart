import 'dart:async';

import 'package:flutter/material.dart';

import 'handle_error.dart';

/// 执行run，然后执行run的加载中状态和错误状态
///
/// 其加载状态对话框样式，可以通过[HandleLoadingStateTheme]设置
Future<T> handleLoadingState<T>(
  BuildContext context,
  FutureOr<T> Function() run, {
  bool Function(dynamic)? handleError,
  bool rootNavigator = false,
}) async {
  final navigator = Navigator.of(context, rootNavigator: rootNavigator);
  final CapturedThemes themes = InheritedTheme.capture(
    from: context,
    to: Navigator.of(
      context,
      rootNavigator: rootNavigator,
    ).context,
  );
  final route = DialogRoute(
    context: context,
    builder: (_) => const _LoadingDialogWidget(),
    barrierColor: Colors.transparent,
    themes: themes,
    barrierDismissible: false,
  );
  unawaited(navigator.push(route));

  try {
    final result = await handlerError(
      context,
      () async => await run(),
      handleError: handleError,
    );
    navigator.removeRoute(route);
    return result;
  } catch (e) {
    navigator.removeRoute(route);
    rethrow;
  }
}

class HandleLoadingStateTheme extends ThemeExtension<HandleLoadingStateTheme> {
  HandleLoadingStateTheme({required this.builder});

  /// 构建加载对话框
  final WidgetBuilder builder;

  @override
  ThemeExtension<HandleLoadingStateTheme> copyWith() {
    return HandleLoadingStateTheme(
      builder: builder,
    );
  }

  @override
  ThemeExtension<HandleLoadingStateTheme> lerp(
      covariant ThemeExtension<HandleLoadingStateTheme>? other, double t) {
    return other ??
        HandleLoadingStateTheme(
          builder: builder,
        );
  }
}

class _LoadingDialogWidget extends StatelessWidget {
  const _LoadingDialogWidget();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<HandleLoadingStateTheme>();
    return theme?.builder.call(context) ??
        Center(
          child: Container(
            height: 68,
            width: 68,
            padding: const EdgeInsets.all(12),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              color: Colors.black.withOpacity(0.38),
            ),
            child: const CircularProgressIndicator(
              strokeWidth: 4,
              color: Colors.white,
            ),
          ),
        );
  }
}
