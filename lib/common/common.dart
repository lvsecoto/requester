import 'dart:convert';

dynamic tryJsonDecode(String? source) {
  try {
    return jsonDecode(source!);
  } catch (e) {
    return null;
  }
}

