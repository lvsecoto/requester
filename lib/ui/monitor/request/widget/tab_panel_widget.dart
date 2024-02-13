import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PanelTab<T> {
  final String title;
  final T groupValue;

  PanelTab(this.title, this.groupValue);
}

class PanelTabWidget<T> extends HookWidget {
  const PanelTabWidget({
    super.key,
    required this.tabs,
    required this.builder,
    this.initialTab,
  });

  final List<PanelTab<T>> tabs;

  final ValueWidgetBuilder<T> builder;

  final T? initialTab;

  @override
  Widget build(BuildContext context) {
    final initialIndex = useMemoized(() {
      final index = tabs.indexWhere((it) => it.groupValue == initialTab);
      if (index == -1) {
        return 0;
      }
      return index;
    }, [initialTab]);
    final controller = useTabController(
      initialLength: tabs.length,
      initialIndex: initialIndex,
      keys: [
        initialTab,
      ]
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TabBar(
          tabAlignment: TabAlignment.start,
          padding: EdgeInsets.zero,
          isScrollable: true,
          controller: controller,
          tabs: [
            ...tabs.map((it) => Tab(text: it.title)),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: controller,
            children: [
              ...tabs.map((tab) => builder(context, tab.groupValue, null)),
            ],
          ),
        ),
      ],
    );
  }
}
