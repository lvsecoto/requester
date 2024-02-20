import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ResponsiveColumn extends StatelessWidget {
  const ResponsiveColumn({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      final width = constraint.maxWidth;
      if (width < 500) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...children.mapIndexed((index, child) {
              return [
                if (index != 0) const Gap(12),
                child,
              ];
            }).flatMap((it) => it),
          ],
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...List.generate(
                children.length ~/ 2,
                (index) => [
                      if (index != 0) const Gap(12),
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(child: children[index * 2]),
                            const Gap(12),
                            if (index * 2 + 1 < children.length)
                              Expanded(child: children[index * 2 + 1])
                            else
                              const Expanded(
                                child: SizedBox.shrink(),
                              ),
                          ],
                        ),
                      ),
                    ]).flatMap(
              (it) => it,
            ),
          ],
        );
      }
    });
  }
}
