part of 'client.dart';

/// 用UID(从缓存)获取Requester信息
@riverpod
class LoadRequesterClient extends _$LoadRequesterClient {
  @override
  FutureOr<RequesterClient> build(String clientUid) async {
    return ref.read(clientManagerProvider)._getRequesterClient(clientUid);
  }
}
