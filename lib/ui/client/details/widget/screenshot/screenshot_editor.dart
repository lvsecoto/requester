import 'dart:io';
import 'dart:typed_data';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pro_image_editor/pro_image_editor.dart';
import 'package:saver_gallery/saver_gallery.dart';

void showScreenshotEditor(BuildContext context, Uint8List data) {
  Navigator.of(context, rootNavigator: true).push(
    MaterialPageRoute(
      builder: (context) => ProImageEditor.memory(
        data,
        configs: const ProImageEditorConfigs(
          emojiEditorConfigs: EmojiEditorConfigs(
            enabled: false,
          ),
          cropRotateEditorConfigs: CropRotateEditorConfigs(
            enabled: false,
          ),
          filterEditorConfigs: FilterEditorConfigs(
            enabled: false,
          ),
          i18n: I18n(
              done: '完成',
              undo: '撤销',
              cancel: '取消',
              redo: '重做',
              remove: '删除',
              textEditor: I18nTextEditor(
                  done: '完成',
                  back: '返回',
                  backgroundMode: '背景模式',
                  bottomNavigationBarText: '添加文字',
                  inputHintText: '输入文字',
                  smallScreenMoreTooltip: '更多',
                  textAlign: '对齐'),
              paintEditor: I18nPaintingEditor(
                bottomNavigationBarText: '形状',
                freestyle: '自由模式',
                arrow: '箭头',
                line: '线条',
                rectangle: '边框',
                circle: '圆形',
                dashLine: '虚线',
                lineWidth: '线宽',
                toggleFill: '切换填充',
                undo: '撤销',
                redo: '重做',
                done: '完成',
                back: '返回',
                smallScreenMoreTooltip: '更多',
              ),
              various: I18nVarious(
                closeEditorWarningCancelBtn: '取消',
                closeEditorWarningConfirmBtn: '确认',
                closeEditorWarningMessage: '确认要退出吗，将丢失截屏图片',
                closeEditorWarningTitle: '确认退出',
                loadingDialogMsg: '加载中',
              )),
        ),
        allowCompleteWithEmptyEditing: true,
        onImageEditingComplete: (bytes) async {
          await _saveImage(bytes);
        },
      ),
    ),
  );
}

Future<void> _requestPermission() async {
  if (Platform.isIOS) {
    (await Permission.photosAddOnly.request()).isGranted;
  }
}

Future<void> _saveImage(Uint8List image) async {
  if (Platform.isAndroid || Platform.isIOS) {
    await _requestPermission();
    await SaverGallery.saveImage(
      image,
      quality: 60,
      name: DateTime.now().toString(),
    );
  } else if (Platform.isMacOS || Platform.isWindows) {
    final file = await getSaveLocation(
      suggestedName: DateTime.now().toString(),
      confirmButtonText: '保存',
      acceptedTypeGroups: [
        const XTypeGroup(
          extensions: ['png'],
          label: '图片',
        ),
      ],
    );
    if (file != null) {
      await File(file.path).writeAsBytes(image);
    }
  }
}
