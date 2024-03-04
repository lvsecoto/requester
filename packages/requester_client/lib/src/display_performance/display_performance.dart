export 'fps.dart';
import 'package:protobuf/protobuf.dart';
import 'package:requester_client/rpc.dart' as rpc;
import 'package:rxdart/rxdart.dart';

class DisplayPerformanceProvider {
  final _subject =
      BehaviorSubject<rpc.DisplayPerformance>.seeded(rpc.DisplayPerformance());

  /// 向Requester报告显示信息
  late final stream = _subject.stream;

  /// 客户端上报帧率
  void reportFps(double fps) {
    _subject.add(_subject.value.copyWith((it) {
      it.fps = fps;
    }));
  }
}
