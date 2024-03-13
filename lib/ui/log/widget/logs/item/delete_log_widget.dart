import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:requester/ui/log/provider/provider.dart' as provider;

class DeleteLogWidget extends HookConsumerWidget {
  /// 包裹在日志条目[child]，实现删除日志[log]操作
  const DeleteLogWidget({
    super.key,
    required this.log,
    required this.child,
  });

  /// 要操作的日志
  final provider.Log log;

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDeleteButtonVisible = useState(false);
    return MouseRegion(
      onEnter: (event) {
        isDeleteButtonVisible.value = true;
      },
      onExit: (event) {
        isDeleteButtonVisible.value = false;
      },
      child: Stack(
        children: [
          child,
          Transform.translate(
            transformHitTests: true,
            offset: const Offset(4, 0),
            child: AnimatedVisibilityWidget(
              isVisible: isDeleteButtonVisible.value,
              animationWidgetBuilder: AnimatedVisibilityWidget.fadeAnimationWidgetBuilder,
              child: HookBuilder(
                builder: (context) {
                  const kFadeOpacity = 0.15;
                  final opacity = useState(kFadeOpacity);
                  return MouseRegion(
                    onEnter: (event) {
                      opacity.value = 1.0;
                    },
                    onExit: (event) {
                      opacity.value = kFadeOpacity;
                    },
                    child: AnimatedOpacity(
                      opacity: opacity.value,
                      duration: kThemeAnimationDuration,
                      child: IconButton(
                        icon: const Icon(Icons.close),
                        color: Theme.of(context).colorScheme.error,
                        onPressed: () {
                          provider.actionDeleteLog(ref, log);
                        },
                      ),
                    ),
                  );
                }
              ),
            ),
          ),
        ],
      ),
    );
  }
}
