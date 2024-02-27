import 'package:drift/drift.dart';
import 'package:requester_client/requester_client.dart';
export 'package:requester_client/requester_client.dart' show OverrideRequest;

final overrideRequestConverter = JsonTypeConverter2.asNullable(TypeConverter.json(
  fromJson: (json) => OverrideRequest.fromJson(json as Map<String, Object?>),
  toJson: (pref) => pref.toJson(),
));
