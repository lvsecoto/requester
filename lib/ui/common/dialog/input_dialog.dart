import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:requester/common/responsive_layout/responsive_layout.dart';

/// 显示输入对话框
Future<String?> showInputDialog<T>(BuildContext context, {
  String? text,
  Widget? title,
  String? hintText,
  List<TextInputFormatter> inputFormatters = const [],
  String? Function(String value)? validator,
}) async {
  return await showDialog<String>(
    context: context,
    builder: (context) =>
        HookBuilder(
          builder: (context) {
            final controller = useTextEditingController(text: text);
            final error = useState<String?>(null);
            final node = useFocusNode();
            void onSubmit() {
              final value = controller.text;
              final hasError = validator?.call(value);
              if (hasError != null) {
                error.value = hasError;
                node.requestFocus();
              } else {
                Navigator.of(context).pop(value);
              }
            }
            return AlertDialog(
              title: title ?? const Text('请输入内容'),
              content: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: WindowClass.compact.maxWidth
                ),
                child: AnimatedSize(
                  duration: kThemeAnimationDuration,
                  alignment: Alignment.topCenter,
                  child: TextField(
                    focusNode: node,
                    controller: controller,
                    autofocus: true,
                    minLines: null,
                    maxLines: null,
                    expands: false,
                    decoration: InputDecoration(
                      hintText: hintText ?? '',
                      errorText: error.value,
                    ),
                    inputFormatters: inputFormatters,
                    onChanged: (value) {
                      error.value = null;
                    },
                    onSubmitted: (value) => onSubmit(),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('取消'),
                ),
                TextButton(
                  onPressed: onSubmit,
                  child: const Text('确认'),
                ),
              ],
            );
          },
        ),
  );
}
