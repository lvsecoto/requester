import 'dart:convert';

import 'package:common/common.dart';
import 'package:dartx/dartx.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:requester/common/common.dart';
import 'package:requester/domain/log/log.dart';
import 'package:rxdart/rxdart.dart';
import 'package:persistence_annotation/persistence_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:conduit_open_api/v3.dart';

part 'model.dart';

part 'provider.dart';

part 'persistence.dart';

part 'document.g.dart';

part 'document.freezed.dart';

@riverpod
DocumentManager documentManager(DocumentManagerRef ref) {
  return DocumentManager(ref);
}

class DocumentManager {
  final AutoDisposeRef<DocumentManager> _ref;

  final _DocumentPersistence _persistence = _DocumentPersistence();

  DocumentManager(this._ref);

  late final _sources = _persistence.observeSources();

  /// 添加源
  Future<void> addSource(String url) async {
    await _persistence.setSources([
      DocumentSource(url: url, name: Uri.parse(url).pathSegments.last),
      ...await _persistence.getSources()
    ]);
  }

  /// 添加源
  Future<void> removeSource(DocumentSource source) async {
    await _persistence
        .setSources([...await _persistence.getSources()]..remove(source));
  }

  /// 获取源列表
  late final provideDocumentSourceList = documentSourceListProvider;

  final Map<DocumentSource, APIDocument> _documents = {};

  /// 添加源
  Future<void> syncSource(DocumentSource source) async {
    final data = (await Dio().get(source.url)).data;
    final doc = APIDocument.fromMap(data);
    _documents[source] = doc;
  }

  /// 分析请求日志
  late final provideAnalyzeLogRequest = analyzeLogRequestProvider;
}
