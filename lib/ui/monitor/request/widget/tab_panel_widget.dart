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
    this.value,
  });

  final List<PanelTab<T>> tabs;

  final ValueWidgetBuilder<T> builder;

  final T? value;

  @override
  Widget build(BuildContext context) {
    final controller = useTabController(initialLength: tabs.length);
    useEffect(() {
      final value = this.value;
      if (value == null) return;
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        final index = tabs.indexWhere((it) => it.groupValue == value);
        if (index == -1) {
          return;
        }
        controller.animateTo(index);
      });
      return;
    }, [value]);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TabBar(
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
