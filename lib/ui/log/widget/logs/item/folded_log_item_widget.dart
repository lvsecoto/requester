import 'dart:math';

import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:requester/app/theme/theme.dart';
import 'package:requester/common/responsive_layout/responsive_layout.dart';
import 'package:requester/domain/log/log.dart';
import 'package:requester/ui/common/common.dart';
import 'package:requester/ui/log/widget/logs/item/app_state_item_widget.dart';
import 'package:rxdart/rxdart.dart';

class FoldedLogItemWidget extends HookWidget {
  /// 显示折叠日志条目
  ///
  /// 目前仅能显示折叠的应用状态日志
  const FoldedLogItemWidget({
    super.key,
    required this.foldedLogs,
  });

  /// 折叠过的日志
  final FoldedLogs foldedLogs;

  /// 扩展日志列表时，最多能允许显示的日志数目，若超过这个数目，则需要用户新建对话框显示
  static const _kMaxExpandLog = 10;

  @override
  Widget build(BuildContext context) {
    final canExpand = foldedLogs.logs.length < _kMaxExpandLog;
    final isExpandedState = useValueNotifier(false);

    // 响应日志列表的变化，并在之后交由对话框处理
    final logsState =
        useMemoized(() => BehaviorSubject.seeded(foldedLogs.logs));
    useMemoized(
      () {
        logsState.add(foldedLogs.logs);
      },
      [foldedLogs.logs.length],
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: HookBuilder(
              builder: (context) {
                final isExpanded = useListenableSelector(
                  isExpandedState,
                  () => canExpand && isExpandedState.value,
                );
                return AnimatedSizeAndFade(
                  alignment: Alignment.topCenter,
                  childKey: isExpanded,
                  child: isExpanded
                      ? _Expanded(foldedLogs: foldedLogs)
                      : _Folded(foldedLogs: foldedLogs),
                );
              },
            ),
          ),
          IconButton(
            onPressed: () {
              if (canExpand) {
                isExpandedState.value = !isExpandedState.value;
              } else {
                _showLogsDialog(context, logsState);
              }
            },
            icon: HookBuilder(builder: (context) {
              final isExpanded = useListenableSelector(
                isExpandedState,
                () => isExpandedState.value,
              );
              return AnimatedSizeAndFade(
                childKey: canExpand,
                child: canExpand
                    ? (isExpanded
                        ? const Icon(Icons.expand_less)
                        : const Icon(Icons.expand_more))
                    : const Icon(Icons.navigate_next),
              );
            }),
          ),
          const Gap(12),
        ],
      ),
    );
  }
}

class _Folded extends StatelessWidget {
  /// 折叠后的组件
  const _Folded({
    required this.foldedLogs,
  });

  /// 折叠过的日志
  final FoldedLogs foldedLogs;

  @override
  Widget build(BuildContext context) {
    final latestLog = foldedLogs.logs.first as LogAppState;
    final oldestLog = foldedLogs.logs.last as LogAppState;
    final timeDescription = ' ${latestLog.time.toHumanReadable()} ~ ${oldestLog.time.toHumanReadable()}';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AnimatedSizeAndFade(
                childKey: latestLog.state,
                child: AppStateWidget(
                  appState: latestLog.state,
                ),
              ),
              const Gap(4),
              const Text('···'),
              const Gap(4),
              AnimatedSizeAndFade(
                childKey: latestLog.state,
                child: AppStateWidget(
                  appState: oldestLog.state,
                ),
              ),
              const Gap(4),
              Container(
                height: 20,
                decoration: ShapeDecoration(
                    color: Theme.of(context).colorScheme.background,
                    shape: const StadiumBorder()),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: AnimatedSizeAndFade(
                  childKey: foldedLogs.logs.length,
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text(
                      '+${foldedLogs.logs.length - 2}',
                      style: Theme.of(context).textTheme.bodyLarge!.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Gap(4),
          AnimatedSizeAndFade(
            childKey: timeDescription,
            child: Text(
              timeDescription,
              style: Theme.of(context).textTheme.labelMedium!.disabled,
            ),
          ),
        ],
      ),
    );
  }
}

class _Expanded extends StatelessWidget {
  /// 展开后的组件
  const _Expanded({
    required this.foldedLogs,
  });

  /// 折叠过的日志
  final FoldedLogs foldedLogs;

  @override
  Widget build(BuildContext context) {
    final logs = foldedLogs.logs;
    return CustomScrollView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      slivers: [
        DiffSliverAnimatedList(
          items: logs.cast<LogAppState>(),
          keySelector: (item) => item.id,
          itemBuilder: (context, log) => LogAppStateItemWidget(
            logAppState: log,
          ),
        ),
      ],
    );
  }
}

/// 显示日志对话框
void _showLogsDialog(
  BuildContext context,
  Stream<List<Log>> logsState,
) {
  showResponsiveDialog(
    context,
    title: HookBuilder(builder: (context) {
      final count = useStream(logsState).data?.length;
      return AnimatedSizeAndFade(
        childKey: count,
        sized: false,
        child: count == null ? const SizedBox.shrink() : Text('展开$count条日志'),
      );
    }),
    isContentScrollable: true,
    body: HookBuilder(builder: (context) {
      final logs = useStream(logsState).data ?? const [];
      return CustomScrollView(
        slivers: [
          DiffSliverAnimatedList(
            items: logs.cast<LogAppState>(),
            keySelector: (item) => item.id,
            itemBuilder: (context, log) => LogAppStateItemWidget(
              logAppState: log,
            ),
          ),
        ],
      );
    }),
  );
}
