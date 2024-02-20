import 'dart:convert';

import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:common/common.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:requester/common/common.dart';
import 'package:requester/domain/document/document.dart';
import 'package:requester/ui/common/common.dart';
import 'package:requester_common/requester_common.dart';

import 'flutter_highlight.dart';

class DataWidgetData {
  DataWidgetData({
    required this.data,
    this.objectAnalysis,
  });

  final String data;
  final ObjectAnalysis? objectAnalysis;
}

class DataWidget extends StatelessWidget {
  const DataWidget({
    super.key,
    required this.data,
  });

  final DataWidgetData data;

  @override
  Widget build(BuildContext context) {
    String data = this.data.data;
    final json = tryJsonDecode(data);
    final objectAnalysis = this.data.objectAnalysis;

    if (json != null) {
      if (objectAnalysis == null) {
        return _Viewer(data: data, language: 'json');
      } else {
        return _DocumentJsonViewer(
          data: json,
          objectAnalysis: objectAnalysis,
        );
      }
    } else if (data.trim().startsWith('<')) {
      return _Viewer(data: data, language: 'html');
    } else if (data.isBlank) {
      return const Center(
        child: Text('没有内容'),
      );
    } else {
      return _Viewer(data: data, language: 'text');
    }
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
    final content = useMemoized(() {
      if (language != 'json') {
        return data;
      }
      return data.jsonFormat();
    });

    return SelectionArea(
      child: Scrollbar(
        controller: controller,
        child: SingleChildScrollView(
          controller: controller,
          child: HighlightView(
            content,
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
    );
  }
}

class _DocumentJsonViewer extends HookWidget {
  const _DocumentJsonViewer({
    required this.data,
    required this.objectAnalysis,
  });

  final dynamic data;

  final ObjectAnalysis objectAnalysis;

  @override
  Widget build(BuildContext context) {
    final isOriginMode = useState(false);
    final root = _useRootNode();

    final treeView = TreeView.simpleTyped(
      tree: root,
      showRootNode: false,
      indentation: const Indentation(
        style: IndentStyle.roundJoint,
      ),
      padding: const EdgeInsets.only(left: 8),
      onTreeReady: (controller) async {
        await Future.delayed(Durations.medium4);
        controller.expandAllChildren(root, recursive: true);
      },
      builder: (context, item) {
        final jsonNode = item.data!;
        var key =
            jsonNode.key is int ? '[${jsonNode.key}]' : jsonNode.key.toString();
        final title =
            key + (jsonNode.fields != null ? '' : ' : ${jsonNode.value}');
        return Padding(
          padding: const EdgeInsets.only(bottom: 8, top: 8, right: 32),
          child: InkWell(
            onTap: () {
              _copyData(context, jsonNode, title);
            },
            child: switch (jsonNode) {
              ObjectAnalysisResultCorrected() => DocumentText(
                  '$title${jsonNode.summary.isNotBlank ? '【${jsonNode.summary}】' : ''}'),
              ObjectAnalysisResultRedundant() =>
                DocumentText(title, isRedundant: true),
              ObjectAnalysisResultMissed() => DocumentText(
                  '$title 期望${jsonNode.expected}，实际${jsonNode.busWas}',
                  isError: true),
            },
          ),
        );
      },
    );

    return Stack(
      fit: StackFit.expand,
      children: [
        treeView,
        AnimatedVisibilityWidget(
          isVisible: isOriginMode.value,
          animationWidgetBuilder:
              AnimatedVisibilityWidget.fadeAnimationWidgetBuilder,
          child: IgnorePointer(
            ignoring: !isOriginMode.value,
            child: Material(
              color: Colors.white,
              child: _Viewer(
                data: jsonEncode(data),
                language: 'json',
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: () {
              isOriginMode.value = !isOriginMode.value;
            },
            icon: AnimatedSizeAndFade(
              childKey: isOriginMode.value,
              child: isOriginMode.value
                  ? const Icon(
                      Icons.remove_red_eye_outlined,
                    )
                  : const Icon(
                      Icons.remove_red_eye,
                    ),
            ),
          ),
        ),
      ],
    );
  }

  Future<(String, Function)?> _copyData(
      BuildContext context, ObjectAnalysisResult jsonNode, String title) {
    return showOptionsDialog(
      context,
      options: [
        (
          '复制key',
          () {
            copyToClipBoard(context, jsonNode.key.toString());
          }
        ),
        (
          '复制value',
          () {
            copyToClipBoard(context, jsonEncode(jsonNode.value).jsonFormat());
          }
        ),
        (
          '复制所有',
          () {
            copyToClipBoard(context, title);
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

  TreeNode<ObjectAnalysisResult> _useRootNode() {
    return useMemoized(() {
      final result = objectAnalysis.analyze(data);
      final root = TreeNode<ObjectAnalysisResult>.root(
        data: result,
      );
      // 展开分析结果
      void expand(TreeNode<ObjectAnalysisResult> node) {
        final fields = node.data?.fields;
        final childNode = fields?.map((field) {
              final childNode = TreeNode<ObjectAnalysisResult>(
                key: '${node.key}${field.key}',
                data: field,
              );
              expand(childNode);
              return childNode;
            }).toList() ??
            [];
        node.addAll(childNode);
        return;
      }

      expand(root);
      return root;
    });
  }
}
