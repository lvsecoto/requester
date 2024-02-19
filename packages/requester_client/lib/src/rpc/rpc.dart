import 'dart:convert';

import 'common/common.pb.dart';

export 'common/common.pb.dart';
export 'client/client_service.pbgrpc.dart';
export 'log/log_service.pbgrpc.dart';
import 'package:fixnum/fixnum.dart';

// void main() {
//   var rpcJson = {
//     'a': 1,
//     'b': [2, 3, 4],
//     'c': 'c',
//     'd': true,
//     'e': [
//       {'a': 1, 'c': 'd'},
//       {'a': 'b', 'c': 'd'}
//     ],
//   }.toRpcJson();
//   print(rpcJson.toJson());
// }

extension JsonToRpcJson on Map<String, dynamic> {
  RpcJsonValue toRpcJson() {
    Map<String, RpcJsonValue> toRpcJson(Map<String, dynamic> map) {
      return map.map((key, value) {
        RpcJsonValue toValue(dynamic value) {
          return switch (value) {
            int() => RpcJsonValue(integerValue: Int64(value)),
            double() => RpcJsonValue(numberValue: value),
            bool() => RpcJsonValue(boolValue: value),
            String() => RpcJsonValue(stringValue: value),
            List() => RpcJsonValue(
                listValue:
                    RpcJsonListValue(values: value.map(toValue).toList()),
              ),
            Map<String, dynamic>() =>
              RpcJsonValue(jsonValue: RpcJson(fields: toRpcJson(value))),
            null => RpcJsonValue(nullValue: RpcJsonNullValue.NULL_VALUE),
            _ => RpcJsonValue(),
          };
        }

        return MapEntry(key, toValue(value));
      });
    }

    return RpcJsonValue(
      jsonValue: RpcJson(
        fields: toRpcJson(jsonDecode(jsonEncode(this))),
      ),
    );
  }
}

extension RpcJsonToJson on RpcJson {
  Map<String, dynamic> toJson() {
    Map<String, dynamic> toJson(Map<String, RpcJsonValue> map) =>
        map.map((key, value) {
          // 列表转换
          List<dynamic> toList(List<RpcJsonValue> values) => values.map(
                (it) {
                  final value = it.getField(it.whichKind().index + 1);
                  return switch (value) {
                    RpcJson(:final fields) => toJson(fields),
                    RpcJsonListValue(:final values) => toList(values),
                    _ => value,
                  };
                },
              ).toList();

          final newValue = value.getField(value.whichKind().index + 1);
          return MapEntry(
            key,
            switch (newValue) {
              RpcJson(:final fields) => toJson(fields),
              RpcJsonListValue(:final values) => toList(values),
              IntX() => newValue.toInt(),
              RpcJsonNullValue.NULL_VALUE => null,
              _ => newValue,
            },
          );
        });

    return toJson(fields);
  }
}
