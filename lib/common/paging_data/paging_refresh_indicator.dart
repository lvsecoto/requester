import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: implementation_imports
import 'package:riverpod/src/notifier.dart';

import 'paging_load_provider.dart';

class PagingRefreshIndicator<Notifier extends PagingLoadNotifierMixin>
    extends ConsumerWidget {

  /// 下拉刷新分页数据，包裹分页数据列表
  ///
  /// 如：
  /// * CustomScrollView
  /// * ListView
  ///
  /// **在手机版才有用**，桌面版使用[PagingRefreshIcon]
  const PagingRefreshIndicator({
    super.key,
    required this.pagingLoadProvider,
    required this.child,
  });

  final Widget child;

  /// 加载更多的[StateNotifier]
  // ignore: invalid_use_of_internal_member
  final NotifierProviderBase<Notifier, PagingLoadState>
      pagingLoadProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
      return child;
    }
    return RefreshIndicator(
      onRefresh: () => ref.read(pagingLoadProvider.notifier).refresh(isByRefreshIndicator: true),
      child: child,
    );
  }
}
