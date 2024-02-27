import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:requester/app/theme/theme.dart';
import 'package:requester/common/common.dart';
import 'package:requester/ui/common/common.dart';
import 'package:requester/ui/log/common/common.dart';
import 'package:requester/ui/log/request/provider/provider.dart';

import 'actions/actions.dart';
import 'request_panel.dart';
import 'response_panel.dart';

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
    return ScaffoldMessenger(
      child: Scaffold(
        backgroundColor: AppTheme.of(context).surfaceContainer,
        appBar: AppBar(
          title: _Title(),
          titleSpacing: 0,
          centerTitle: false,
          backgroundColor: Colors.transparent,
          actions: const [
            ActionQuickCreateRequestOverride(),
          ],
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
            children: const [
              RequestPanel(),
              ResponsePanel(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Title extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final request = watchLogRequest(ref);
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        _copyUrl(context, ref);
      },
      child: AnimatedSwitcher(
        duration: kThemeAnimationDuration,
        child: KeyedSubtree(
          key: ValueKey(request == null),
          child: request == null
              ? const SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: SizedBox(
                    width: double.infinity,
                    child: RequestSummaryWidget(
                      logRequest: request,
                      leading: MethodWidget(
                        logRequest: request,
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Future<(String, Function)?> _copyUrl(BuildContext context, WidgetRef ref) {
    return showOptionsDialog(
      context,
      options: [
        (
          '复制url',
          () {
            final url = getRequestUrl(ref);
            if (url == null) {
              return;
            }
            copyToClipBoard(context, url);
          }
        ),
        (
          '复制curl',
          () {
            final curl = getRequestCurl(ref);
            if (curl == null) {
              return;
            }
            copyToClipBoard(context, curl);
          }
        ),
      ],
      optionBuilder: (context, item, onTap) => ListTile(
        onTap: () {
          onTap(item);
          item.$2.call();
        },
        title: Text(item.$1),
      ),
    );
  }
}
