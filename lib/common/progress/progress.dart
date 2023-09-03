/// 进度相关
library progress;

import 'package:dartx/dartx.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rxdart/rxdart.dart';

export 'provider.dart';
export 'progress_loading_button.dart';

part 'progress.freezed.dart';

@freezed
sealed class Progress<T> with _$Progress<T> {
  const Progress._();

  /// 表示一个进度
  ///
  /// 可以携带一个数据[data]
  const factory Progress({required int current, required int total, T? data}) =
      ProgressDeterminate;

  /// 表示一个没有具体数值的进度
  ///
  /// 可以携带一个数据[data]
  const factory Progress.indeterminate([T? data]) = ProgressIndeterminate;

  /// 表示加载已经完成
  const factory Progress.done([T? data]) = ProgressDone;

  /// 表示加载出现错误
  const factory Progress.error([
    dynamic e,
    StackTrace? stackTrace,
    T? data,
  ]) = ProgressError;

  /// 是否处于完成的状态，错误状态也算完成
  bool get isDone => map(
        (_) => false,
        indeterminate: (_) => false,
        done: (_) => true,
        error: (_) => true,
      );

  bool get isLoading => map(
        (_) => true,
        indeterminate: (_) => true,
        done: (_) => false,
        error: (_) => false,
      );
}

typedef ProgressStream = Stream<Progress>;

extension ProgressStreamEx on Iterable<ProgressStream> {
  /// 串行两个[Progress]的进度
  Stream<Progress> concat() async* {
    yield const Progress.indeterminate();
    await for (var progress in Rx.concat(this)) {
      // 中间的done将会被去掉
      if (progress is! ProgressDone) {
        yield progress;
      }
    }
    yield const Progress.done();
  }

  /// 并行两个[Progress]的进度
  Stream<Progress<T>> merge<T>() async* {
    yield const Progress.indeterminate();
    await for (var perChunkProgress in Rx.combineLatestList(this)) {
      final canDeterminate = perChunkProgress
          .filter((it) => it is ProgressDeterminate)
          .cast<ProgressDeterminate>();
      final currentSum = canDeterminate.sumBy((it) => it.current);
      final totalSum = canDeterminate.sumBy((it) => it.total);
      if (totalSum == 0) {
        yield const Progress.indeterminate();
      } else {
        yield Progress<T>(
          current: currentSum,
          total: totalSum,
        );
      }
    }
    yield Progress<T>.done();
  }
}
