import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:requester/common/responsive_layout/dialog.dart';
import 'package:requester_client/requester_client.dart';

Future<OverrideRequest?> showOverrideRequestDialog(
  BuildContext context, {
  Widget? title,
  Widget? actionTitle,
  OverrideRequest? overrideRequest,
}) async {
  final editRemark = TextEditingController(text: overrideRequest?.remark);
  final editPath = TextEditingController(text: overrideRequest?.matcher.path);
  final editMethod =
      TextEditingController(text: overrideRequest?.matcher.method);
  final editResponseCode = TextEditingController(
      text: overrideRequest?.action.responseCode?.toString());
  final editResponseBody = TextEditingController(
      text: overrideRequest?.action.responseBody?.toString());
  return showResponsiveDialog<OverrideRequest>(
    context,
    title: title ?? const Text('添加重载规则'),
    body: EditOverrideRequestDialog(
      editRemark: editRemark,
      editPath: editPath,
      editMethod: editMethod,
      editResponseCode: editResponseCode,
      editResponseBody: editResponseBody,
    ),
    actions: [
      HookBuilder(builder: (context) {
        final canSubmit =
            useListenableSelector(editPath, () => editPath.text.isNotBlank);
        return FilledButton(
          onPressed: canSubmit
              ? () {
                  Navigator.of(context).pop(
                    overrideRequest?.copyWith(
                          remark: editRemark.text,
                          matcher: OverrideRequestMatcher(
                            path: editPath.text,
                            method: editMethod.text,
                          ),
                          action: OverrideRequestAction.replace(
                            responseCode: int.tryParse(editResponseCode.text),
                            responseBody: editResponseBody.text,
                          ),
                        ) ??
                        OverrideRequest(
                          matcher: OverrideRequestMatcher(
                            path: editPath.text,
                            method: editMethod.text,
                          ),
                          action: OverrideRequestAction.replace(
                            responseCode: int.tryParse(editResponseCode.text),
                            responseBody: editResponseBody.text,
                          ),
                        ),
                  );
                }
              : null,
          child: actionTitle ?? const Text('确定'),
        );
      }),
    ],
  );
}

class EditOverrideRequestDialog extends HookWidget {
  const EditOverrideRequestDialog({
    super.key,
    required this.editRemark,
    required this.editPath,
    required this.editMethod,
    required this.editResponseCode,
    required this.editResponseBody,
  });

  final TextEditingController editRemark;
  final TextEditingController editPath;
  final TextEditingController editMethod;
  final TextEditingController editResponseCode;
  final TextEditingController editResponseBody;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Gap(12),
        TextField(
          controller: editRemark,
          maxLines: null,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: '备注',
            hintText: '输入备注方便区分规则',
          ),
        ),
        const Gap(16),
        const Text('匹配'),
        const Gap(12),
        TextField(
          controller: editPath,
          maxLines: null,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: '路径',
            hintText: '输入匹配路径(必填)',
          ),
        ),
        const Gap(12),
        TextField(
          controller: editMethod,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: '方法',
            hintText: '输入匹配路径',
          ),
        ),
        const Gap(16),
        const Text('重载'),
        const Gap(12),
        TextField(
          controller: editResponseCode,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: '返回代码',
            hintText: '输入数字',
          ),
        ),
        const Gap(12),
        TextField(
          controller: editResponseBody,
          maxLines: null,
          minLines: 4,
          decoration: const InputDecoration(
            alignLabelWithHint: true,
            border: OutlineInputBorder(),
            labelText: '返回内容',
            hintText: '输入匹配路径',
          ),
        ),
      ],
    );
  }
}
