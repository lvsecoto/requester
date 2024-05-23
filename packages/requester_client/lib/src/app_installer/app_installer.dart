import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_app_installer/flutter_app_installer.dart';

class AppInstallerProvider {
  late final _installer = FlutterAppInstaller();

  /// 从数据流安装应用
  Future<void> installApp(Stream<List<int>> data) async {
    if (!Platform.isAndroid) {
      throw '仅支持安装Android应用';
    }
    debugPrint('requester: 开始接收应用安装包');
    String filePath = await _buildApkFilePath();
    final file = File(filePath);
    final fileSink = file.openWrite();
    await fileSink.addStream(data);
    debugPrint('requester: 安装应用安装包');
    await _installer.installApk(filePath: filePath);
    debugPrint('requester: 安装成功!');
  }

  /// 构建APK应用文件路径
  Future<String> _buildApkFilePath() async {
    return '${(await getApplicationCacheDirectory())!.uri.toFilePath()}/${DateTime.now().microsecond}.apk';
  }
}

