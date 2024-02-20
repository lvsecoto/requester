import 'dart:convert';

dynamic tryJsonDecode(String? source) {
  try {
    return jsonDecode(source!);
  } catch (e) {
    return null;
  }
}

extension JsonFormattedEx on String {
  static const _encoder = JsonEncoder.withIndent('   ');

  String jsonFormat() {
    final json = tryJsonDecode(this);
    if (json == null) {
      return this;
    } else {
      return _encoder.convert(json);
    }
  }
}
