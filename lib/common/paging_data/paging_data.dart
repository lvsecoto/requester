/// # 分页加载
///
/// 这个模块能适用大部份分页加载场景，包括
/// 1. 网络
/// 2. 数据库
///
/// ## 用法
/// 1. 把分页数据用[PagingData]来封装好
/// 2. 用[PagingLoadNotifierMixin] mixin [NotifierProvider]
/// 3. 用这个[NotifierProvider]执行刷新，加载更多等
///
/// ## 用来展示分页加载的widget
///
/// ### 列表
///
/// 列表只需要按listView来显示就行了
///
/// ### 加载更多
///
/// 在列表最后插入一个条目[PagingLoadMoreStateWidget]，有两个作用
/// * 用来显示加载更多状态，
/// * 每当显示这个条目时，执行加载更多[PagingLoadNotifierMixin.loadMore]
///
library paging_load;

export 'paging_load_provider.dart';
export 'paging_load_more_state_widget.dart';
export 'paging_refresh_indicator.dart';

/// 分页加载数据
abstract class PagingData<NextPageArg, T> {
  static PagingData<NextPageArg, T> empty<NextPageArg, T>(NextPageArg nextPageArg) =>
      PagingDataEmpty<NextPageArg, T>(nextPageArg);

  /// 是否有更多数据
  bool get hasMore;

  /// 加载下一页所需的参数
  NextPageArg get nextPageArg;

  /// 这一页的数据
  List<T> get data;
}

class PagingDataEmpty<NextPageArg, T> extends PagingData<NextPageArg, T> {
  @override
  final hasMore = false;

  @override
  final NextPageArg nextPageArg;

  @override
  final data = List.empty();

  PagingDataEmpty(this.nextPageArg);
}
