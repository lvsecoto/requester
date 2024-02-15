part of 'document.dart';

@persistenceAnnotation
class _DocumentPersistence extends _$_DocumentPersistence {
  static const List<DocumentSource> sources = [];

  _DocumentPersistence() : super(Hive.openLazyBox('document'));
}