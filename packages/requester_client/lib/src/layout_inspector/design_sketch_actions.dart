part of 'layout_inspector.dart';

class _DesignSketchActions extends HookWidget {
  /// 设计稿控制操作
  const _DesignSketchActions({
    required this.designSketchFocusNode,
    required this.magnifierController,
    required this.designSketchVisible,
    required this.onDone,
  });

  final FocusNode designSketchFocusNode;
  final ValueNotifier<bool> magnifierController;
  final ValueNotifier<bool> designSketchVisible;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.all(18),
      child: Row(
        children: [
          IconButton.outlined(
            onPressed: onDone,
            icon: const Icon(Icons.exit_to_app),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              designSketchVisible.value = !designSketchVisible.value;
            },
            onLongPressDown: (details) {
              designSketchVisible.value = !designSketchVisible.value;
            },
            onLongPressUp: () {
              designSketchVisible.value = !designSketchVisible.value;
            },
            child: IconButton.filledTonal(
              onPressed: () {},
              icon: ValueListenableBuilder(
                valueListenable: designSketchVisible,
                builder: (context, isDesignSketchVisible, _) =>
                    AnimatedSwitcher(
                  duration: kThemeAnimationDuration,
                  child: KeyedSubtree(
                    key: ValueKey(isDesignSketchVisible),
                    child: Icon(
                      isDesignSketchVisible
                          ? Icons.difference
                          : Icons.difference_outlined,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          IconButton.filledTonal(
            onPressed: () {
              magnifierController.value = !magnifierController.value;
            },
            icon: ValueListenableBuilder(
              valueListenable: magnifierController,
              builder: (context, isMagnifierVisible, _) => AnimatedSwitcher(
                duration: kThemeAnimationDuration,
                child: KeyedSubtree(
                  key: ValueKey(isMagnifierVisible),
                  child: Icon(
                    isMagnifierVisible ? Icons.zoom_in : Icons.zoom_out,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          HookBuilder(builder: (context) {
            final hasFocus = useListenableSelector(
              designSketchFocusNode,
              () => designSketchFocusNode.hasFocus,
            );
            return IconButton.filledTonal(
              onPressed: () {
                if (!hasFocus) {
                  designSketchFocusNode.requestFocus();
                } else {
                  designSketchFocusNode.unfocus();
                }
              },
              icon: AnimatedSwitcher(
                duration: kThemeAnimationDuration,
                child: KeyedSubtree(
                  key: ValueKey(hasFocus),
                  child: Icon(hasFocus ? Icons.check : Icons.pan_tool),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
