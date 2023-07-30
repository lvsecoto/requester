import 'dart:convert';

import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

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
    } else if (data.trim().startsWith('<')) {
      language = 'html';
    }
    return SelectionArea(
      child: data.isBlank
          ? const Center(
              child: Text('没有内容'),
            )
          : _Viewer(data: data, language: language),
    );
  }
}

class _Viewer extends HookWidget {
  const _Viewer({
    required this.data,
    required this.language,
  });

  final String data;
  final String language;

  @override
  Widget build(BuildContext context) {
    final controller = useScrollController();
    return Scrollbar(
      controller: controller,
      child: SingleChildScrollView(
        controller: controller,
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
    );
  }
}
