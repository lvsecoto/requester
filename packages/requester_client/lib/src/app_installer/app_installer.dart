import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:flutter_app_installer/flutter_app_installer.dart';

class AppInstallerProvider {
  late final _installer = FlutterAppInstaller();

  /// 从数据流安装应用
  Future<void> installApp(Stream<List<int>> data) async {
    String filePath = await _buildApkFilePath();
    final file = File(filePath);
    final fileSink = file.openWrite();
    await fileSink.addStream(data);
    await _installer.installApk(filePath: filePath);
  }

  Future<void> downloadApk() async {
    // final downloadCompleter = Completer();
    // try {
    //   await _network.download(canUpgrade.url, filePath);
    //   downloadCompleter.complete();
    // } catch (e, stacktrace) {
    //   downloadCompleter.completeError(e, stacktrace);
    // }
  }

  /// 构建APK应用文件路径
  Future<String> _buildApkFilePath() async {
    return '${(await getExternalStorageDirectory())!.uri.toFilePath()}/${DateTime.now().microsecond}.apk';
  }
}

