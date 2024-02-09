import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<void> saveObject<T>(
  String key,
  T object, {
  String Function(T)? encode,
}) async {
  File file = await _getFile(key);

  if (!await file.exists()) {
    await file.create();
  }

  final data = encode?.call(object) ?? jsonEncode((object as dynamic).toJson());
  await file.writeAsString(data);
}

Future<T> getObject<T>(
  String key, {
  required T Function(String) decode,
  String Function(T)? encode,
  required T defaultValue,
}) async {
  File file = await _getFile(key);
  if (!await file.exists()) {
    final object = defaultValue;
    if (encode != null) {
      await saveObject(key, object);
    }
    return object;
  }

  final string = await file.readAsString();
  return decode.call(string);
}

Future<File> _getFile(String key) async {
  var dir = await getApplicationDocumentsDirectory();
  dir = Directory('${dir.path}/requester');
  if (!await dir.exists()) {
    await dir.create();
  }
  final file = File('${dir.path}/$key');
  return file;
}
