import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'window_class.dart';

extension ResponsiveWindowClassEx on WindowClass {
  bool get isDialogShrinkWrap => this != WindowClass.compact;
}

Future<T?> showResponsiveDialog<T>(
    BuildContext context, {
      required Widget title,

      /// 对话框主要部分，如果过长，则可以滚动
      required Widget body,

      /// 操作按钮
      List<Widget>? actions,

      /// 可以在对话框外包裹[Widget]
      Widget Function(BuildContext context, Widget child)? builder,

      /// 如果内容是自带滚动的，那么[body]不会包裹SingleChildScrollView
      bool isContentScrollable = false,
      bool isPaddingLeft = true,
      bool isPaddingTop = true,
      bool isPaddingRight = true,
      bool isPaddingBottom = true,
    }) async {
  if (!isContentScrollable) {
    body = SingleChildScrollView(
      child: body,
    );
  }
  final child = Consumer(builder: (context, ref, _) {
    final windowClass = ref.watch(windowClassNotifierProvider);
    if (windowClass != WindowClass.compact) {
      // 非小屏幕，显示普通对话框：居中，高度包裹
      final theme = Theme.of(context).textTheme;
      return SafeArea(
        child: Dialog(
          insetAnimationDuration: kThemeAnimationDuration,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 560,
            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: isPaddingLeft ? 24 : 0,
                top: 24,
                right: isPaddingRight ? 24 : 0,
                bottom: 24,
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // 关闭按钮
                  const Positioned(
                    top: -8,
                    right: -8,
                    child: CloseButton(),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 标题
                      DefaultTextStyle(
                        style: theme.headlineSmall!,
                        child: title,
                      ),
                      if (isPaddingTop) const SizedBox(height: 16),
                      // 内容主要部分
                      Flexible(
                        child: body,
                      ),
                      // 按钮
                      if (actions != null) ...[
                        const SizedBox(height: 8),
                        ButtonBar(
                          children: actions,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    // 小屏幕，显示全屏对话框：body部分伸展
    return Dialog.fullscreen(
      insetAnimationDuration: kThemeAnimationDuration,
      child: Scaffold(
        appBar: AppBar(
          title: title,
          leading: const CloseButton(),
        ),
        body: Column(
          children: [
            // 对话框主要内容部分
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: isPaddingLeft ? 16 : 0,
                  top: isPaddingTop ? 16 : 0,
                  right: isPaddingRight ? 16 : 0,
                ),
                child: body,
              ),
            ),
            // 按钮
            if (actions != null)
              SafeArea(
                minimum: const EdgeInsets.all(8),
                bottom: true,
                child: ButtonBar(
                  children: actions,
                ),
              ),
          ],
        ),
      ),
    );
  });
  return await showModal<T>(
    context: context,
    useRootNavigator: true,
    configuration: const FadeScaleTransitionConfiguration(
      reverseTransitionDuration: Duration(milliseconds: 240),
    ),
    builder: (context) {
      if (builder != null) return builder(context, child);
      return child;
    },
  );
}