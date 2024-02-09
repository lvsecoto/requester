import 'package:flutter/material.dart';

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
          children: children,
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...List.generate(
                children.length ~/ 2 + 1,
                (index) => Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: children[index * 2]),
                        if (index * 2 + 1 < children.length)
                          Expanded(child: children[index * 2 + 1])
                        else const Expanded(
                          child: SizedBox.shrink(),
                        ),
                      ],
                    )),
          ],
        );
      }
      return Container();
    });
  }
}
