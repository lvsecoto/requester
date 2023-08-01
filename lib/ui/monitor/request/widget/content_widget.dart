import 'package:common_dc/common_dc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:requester/app/theme/theme.dart';
import 'package:requester/ui/monitor/common/method_widget.dart';
import 'package:requester/ui/monitor/common/path_widget.dart';
import 'package:requester/ui/monitor/request/provider/provider.dart';
import 'package:requester/ui/monitor/request/widget/request_panel.dart';
import 'package:requester/ui/monitor/request/widget/response_panel.dart';

class ContentWidget extends HookConsumerWidget {
  const ContentWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final splitDividerAnimationController =
        useAnimationController(duration: kThemeAnimationDuration);
    final splitDividerColorTween = ColorTween(
      begin: Colors.black12,
      end: Colors.black54,
    );
    final controller = useMemoized(
          () => MultiSplitViewController(
        areas: kDefaultMonitorSplitAreas,
      ),
    );
    return Scaffold(
      backgroundColor: AppTheme.of(context).surfaceContainer,
      appBar: AppBar(
        title: _Title(),
        backgroundColor: Colors.transparent,
        toolbarHeight: kToolbarHeight + 16,
      ),
      body: MultiSplitViewTheme(
        data: MultiSplitViewThemeData(
          dividerThickness: 16,
        ),
        child: MultiSplitView(
          controller: controller,
          axis: Axis.vertical,
          onDividerDoubleTap: (it) {
            controller.areas = kDefaultMonitorSplitAreas;
          },
          dividerBuilder:
              (axis, index, resizable, dragging, highlighted, themeData) =>
                  HookBuilder(builder: (context) {
            useEffect(() {
              if (dragging) {
                splitDividerAnimationController.forward();
              } else {
                splitDividerAnimationController.reverse();
              }
              return null;
            }, [dragging]);
            return AnimatedBuilder(
              animation: splitDividerAnimationController,
              builder: (context, child) => IconTheme(
                data: IconThemeData(
                  color: splitDividerColorTween
                      .evaluate(splitDividerAnimationController),
                ),
                child: const Icon(
                  Icons.drag_handle,
                  size: 16,
                ),
              ),
            );
          }),
          children: [
            const RequestPanel(),
            const ResponsePanel(),
          ],
        ),
      ),
    );
  }
}

class _Title extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final request = loadMonitorRequest(ref);
    return DCAnimatedSizeAndFade(
      childKey: request == null,
      alignment: Alignment.centerLeft,
      child: request == null
          ? const SizedBox.shrink()
          : Padding(
            padding: const EdgeInsets.only(top: 16),
            child: SizedBox(
        width: double.infinity,
              child: PathWidget(
                  request: request,
                  leading: MethodWidget(
                    request: request,
                  ),
                ),
            ),
          ),
    );
  }
}
