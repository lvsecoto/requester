part of 'document.dart';

@freezed
class DocumentSource with _$DocumentSource {
  const factory DocumentSource({
    required String url,
    required String name,
  }) = _DocumentSource;

  factory DocumentSource.fromJson(Map<String, dynamic> json) =>
      _$DocumentSourceFromJson(json);
}

