import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_highlight/themes/github.dart';

import 'flutter_highlight.dart';

class DataWidget extends StatelessWidget {
  const DataWidget({
    super.key,
    required this.data,
  });

  final String data;

  static const _encoder = JsonEncoder.withIndent('   ');

  @override
  Widget build(BuildContext context) {
    String language = 'text';
    String data = this.data;

    if (data.trim().startsWith('{')) {
      language = 'json';
      try {
        data = _encoder.convert(jsonDecode(data));
      } catch (_) {}
    }
    return SelectionArea(
      child: PrimaryScrollController(
        controller: ScrollController(),
        child: Scrollbar(
          child: SingleChildScrollView(
            child: HighlightView(
              data,
              language: language,
              theme: {
                ...githubTheme,
                'root': githubTheme['root']!.copyWith(
                  backgroundColor: Colors.transparent,
                ),
              },
              padding: const EdgeInsets.all(8),
            ),
          ),
        ),
      ),
    );
  }
}
