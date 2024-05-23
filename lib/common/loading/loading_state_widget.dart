// ignore_for_file: invalid_use_of_internal_member, implementation_imports

import 'dart:async';

import 'package:dartx/dartx.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/src/framework.dart';
import 'package:riverpod/src/notifier.dart';

import '../common.dart';

export 'loading_state_theme.dart';

/// 显示[futureProvider]的加载状态，加载的时候[child]不显示
/// {@macro loading_state.LoadingStateWidget}
class ProviderLoadingStateWidget extends HookConsumerWidget {
  /// 等待多个Provider完成，并支持重试
  ///
  /// {@macro loading_state.LoadingStateWidget}
  const ProviderLoadingStateWidget.multiple({
    super.key,
    required this.futureProvider,
    required this.child,
    this.keepContentDuringLoading = false,
    this.onReady,
  });

  /// 等待Provider完成，并支持重试
  ///
  /// {@macro loading_state.LoadingStateWidget}
  ProviderLoadingStateWidget({
    super.key,
    required FutureProvider futureProvider,
    required this.child,
    this.keepContentDuringLoading = false,
    this.onReady,
  }) : futureProvider = [futureProvider];

  /// 要等待的provider，可以重试
  final List<FutureProvider> futureProvider;

  /// provider完成后显示的widget
  final Widget child;

  final VoidCallback? onReady;

  /// 是否在加载中时保持显示[child]
  final bool keepContentDuringLoading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// 首次进入，发现有错误的缓存，就刷新一次
    useMemoized(() {
      futureProvider.filter((it) => ref.read(it).hasError).forEach((it) {
        ref.invalidate(it);
      });
    });
    return FutureLoadingStateWidget(
      futures:
          futureProvider.map((provider) => ref.watch(provider.future)).toList(),
      onRetry: () {
        for (var provider in futureProvider) {
          ref.invalidate(provider);
        }
      },
      keepContentDuringLoading: keepContentDuringLoading,
      onReady: onReady,
      child: child,
    );
  }
}

typedef FutureStateProvider = AsyncSelector;

/// 显示[futureProvider]的加载状态，加载的时候[child]不显示
/// {@macro loading_state.LoadingStateWidget}
class AutoDisposeProviderLoadingStateWidget extends HookConsumerWidget {
  /// 等待多个Provider完成，并支持重试，和[ProviderLoadingStateWidget]一样，
  /// [AutoDisposeFutureProvider]版本
  ///
  /// {@macro loading_state.LoadingStateWidget}
  const AutoDisposeProviderLoadingStateWidget.multiple({
    super.key,
    required this.futureProvider,
    this.dependencyProvider = const [],
    this.onReady,
    required this.child,
    this.keepContentDuringLoading = false,
  });

  /// 等待Provider完成，并支持重试，和[ProviderLoadingStateWidget]一样，
  /// [AutoDisposeFutureProvider]版本
  ///
  /// {@macro loading_state.LoadingStateWidget}
  AutoDisposeProviderLoadingStateWidget({
    super.key,
    required FutureStateProvider futureProvider,
    this.dependencyProvider = const [],
    required this.child,
    this.onReady,
    this.keepContentDuringLoading = false,
  }) : futureProvider = [futureProvider];

  /// 要等待的provider，可以重试
  final List<FutureStateProvider> futureProvider;

  /// 依赖的provider，用于重试
  final List<ProviderBase> dependencyProvider;

  /// provider完成后显示的widget
  final Widget child;

  /// [child]准备就绪回调
  final VoidCallback? onReady;

  /// 是否在加载中时保持显示[child]
  final bool keepContentDuringLoading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// 首次进入，发现有错误的缓存，就刷新一次
    useMemoized(() {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        [...futureProvider, ...dependencyProvider]
            .filter((it) => ref.read(it as ProviderBase) is AsyncError)
            .forEach((it) {
          ref.invalidate(it as ProviderBase);
        });
      });
    });
    return FutureLoadingStateWidget(
      futures:
          futureProvider.map((provider) => ref.watch(provider.future)).toList(),
      onRetry: () {
        if (dependencyProvider.isNotEmpty) {
          for (var provider in dependencyProvider) {
            ref.invalidate(provider);
          }
        } else {
          for (var provider in futureProvider) {
            ref.invalidate(provider as ProviderBase);
          }
        }
      },
      keepContentDuringLoading: keepContentDuringLoading,
      onReady: onReady,
      child: child,
    );
  }
}

class PagingLoadingStateWidget extends HookConsumerWidget {
  /// 显示[pagingLoadNotifier]的加载状态，加载的时候[child]不显示
  /// {@macro loading_state.LoadingStateWidget}
  const PagingLoadingStateWidget({
    super.key,
    required this.pagingLoadNotifier,
    required this.child,
    this.onReady,
  });

  final NotifierProviderBase<PagingLoadNotifierMixin, PagingLoadState>
      pagingLoadNotifier;

  final Widget child;

  /// [child]准备就绪回调
  final VoidCallback? onReady;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pagingLoadState = ref.watch(pagingLoadNotifier);
    final theme = Theme.of(context).extension<LoadingStateTheme>();
    // 数据为空显示内容，如果没有指定，则使用child
    final empty = (theme?.emptyBuilder?.call(context) ?? child);
    return LoadingStateWidget(
      isLoading:
          !pagingLoadState.isByRefreshIndicator && pagingLoadState.isRefreshing,
      error: pagingLoadState.lastRefreshError,
      stackTrace: pagingLoadState.lastRefreshErrorStacktrace,
      onRetry: () {
        ref
            .read(pagingLoadNotifier.notifier)
            .refresh(isByRefreshIndicator: true);
      },
      keepContentDuringLoading: pagingLoadState.hasInitialized,
      skipShowUpAnimation: true,
      child: Stack(
        children: [
          AnimatedVisibilityWidget(
            animationWidgetBuilder:
                AnimatedVisibilityWidget.fadeAnimationWidgetBuilder,
            isVisible:
                !pagingLoadState.isRefreshing && pagingLoadState.data.isEmpty,
            child: empty,
          ),
          _ShowUp(child: child),
        ],
      ),
    );
  }
}

class FutureLoadingStateWidget extends HookWidget {
  /// {@template loading_state.LoadingStateWidget}
  ///
  /// ## 简介
  ///
  /// 等待[futures]完成，显示CircleProgress，完成后child才显示
  ///
  /// * 加载过程，child不会被加入WidgetTree，这就避免了没数据界面显示错误或者不正常
  /// * 如果加载过快，会等待到最小加载时间，才显示widget
  /// * 如果加载过程有错误，就显示错误，设置了[onRetry]还可以重试
  /// {@endtemplate}
  const FutureLoadingStateWidget({
    super.key,
    required this.child,
    required this.futures,
    this.keepContentDuringLoading = false,
    this.onRetry,
    this.onReady,
  });

  /// 加载完成后显示的widget
  final Widget child;

  /// 要显示的加载过程，可以有多个
  final List<Future> futures;

  /// 重试回调，如果设置了，就会显示重试按钮
  final VoidCallback? onRetry;

  /// [child]准备就绪回调
  final VoidCallback? onReady;

  /// 是否在加载中时保持显示[child]
  final bool keepContentDuringLoading;

  @override
  Widget build(BuildContext context) {
    // widget 会根据这个future显示，它的返回值是描述[future]是否非常快速的完成，
    // 如果是，就不会有显示动画
    final ensureDelayFuture = useState<Future<bool>?>(null);
    useEffect(() {
      ensureDelayFuture.value = () async {
        const delayDeadZoneStart = Duration(milliseconds: 20);
        const delayDeadZoneEnd = Duration(milliseconds: 500);
        const minDelay = Duration(milliseconds: 800);
        final beginTime = DateTime.now();
        Object? error;
        StackTrace? stacktrace;
        try {
          await Future.wait(futures);
        } catch (e, s) {
          error = e;
          stacktrace = s;
        }
        final diff = DateTime.now().difference(beginTime);
        final isFinishedQuickly = diff <= delayDeadZoneStart;
        if (diff > delayDeadZoneStart && diff < delayDeadZoneEnd) {
          await Future.delayed(minDelay - diff);
        }
        if (error != null) {
          assert(stacktrace != null);
          debugPrint(error.toString());
          debugPrint(stacktrace.toString());
          Error.throwWithStackTrace(error, stacktrace!);
        }

        onReady?.call();
        return isFinishedQuickly;
      }();
      return null;
    }, futures);

    final asyncValue = useFuture(ensureDelayFuture.value);

    final isDone = asyncValue.connectionState == ConnectionState.done;
    final error = asyncValue.error;
    final isFinishedQuickly = asyncValue.data;

    return LoadingStateWidget(
      error: error,
      stackTrace: asyncValue.stackTrace,
      isLoading: !isDone,
      onRetry: onRetry,
      keepContentDuringLoading: keepContentDuringLoading || asyncValue.hasData,
      // 不是非常快速完成，所以要显示动画
      skipShowUpAnimation: isFinishedQuickly == true,
      child: child,
    );
  }
}

class LoadingStateWidget extends StatelessWidget {
  const LoadingStateWidget({
    super.key,
    this.skipShowUpAnimation = false,
    required this.child,
    required this.isLoading,
    this.error,
    this.stackTrace,
    this.onRetry,
    this.keepContentDuringLoading = false,
  });

  /// 是否在加载中时保持显示[child]
  final bool keepContentDuringLoading;

  /// 当[child]显示时，不显示动画
  final bool skipShowUpAnimation;

  /// 显示内容
  final Widget child;

  /// 是否在加载中，将显示错误按钮
  final bool isLoading;

  /// 错误信息
  final dynamic error;

  /// 错误堆栈
  final StackTrace? stackTrace;

  /// 重试
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    var child = this.child;
    if (!skipShowUpAnimation) {
      child = _ShowUp(
        key: const ValueKey(true),
        child: this.child,
      );
    }

    final bool showChild = !isLoading || keepContentDuringLoading;
    child = KeyedSubtree(
      key: ValueKey((showChild, error)),
      child: switch (isLoading) {
        true => keepContentDuringLoading ? child : const _LoadingStateWidget(),
        false => switch (error) {
            null => child,
            _ => _ErrorStateWidget(
                error: error,
                stackTrace: stackTrace,
                onRetry: onRetry,
              ),
          }
      },
    );
    child = Stack(
      fit: StackFit.expand,
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          switchInCurve: Curves.easeOut,
          switchOutCurve: Curves.easeOut,
          child: child,
        ),
        if (keepContentDuringLoading)
          AnimatedVisibilityWidget(
            animationWidgetBuilder:
                AnimatedVisibilityWidget.fadeAnimationWidgetBuilder,
            isVisible: isLoading,
            child: keepContentDuringLoading
                ? const Center(child: _LoadingStateWidget())
                : const SizedBox.shrink(),
          ),
      ],
    );
    return child;
  }
}

class _LoadingStateWidget extends StatelessWidget {
  /// 加载中界面
  const _LoadingStateWidget();

  @override
  Widget build(BuildContext context) {
    return const SizedBox.square(
      dimension: 40,
      child: CircularProgressIndicator(),
    );
  }
}

class _ErrorStateWidget extends StatelessWidget {
  /// 显示错误信息，以及重试按钮
  const _ErrorStateWidget({
    this.error,
    required this.stackTrace,
    this.onRetry,
  });

  /// 错误信息
  final dynamic error;

  /// 错误堆栈
  final StackTrace? stackTrace;

  /// 重试
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(error.toString()),
            if (kDebugMode && stackTrace != null)
              Flexible(
                child: Scrollbar(
                  trackVisibility: true,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    child: Text(stackTrace.toString()),
                  ),
                ),
              ),
            if (onRetry != null) ...[
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: onRetry,
                child: const Text('重试'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ShowUp extends HookWidget {
  /// 加载完毕后[child]显示动画
  const _ShowUp({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 400),
    );
    final animation = useMemoized(() {
      controller.forward();
      return controller.drive(CurveTween(curve: Curves.fastLinearToSlowEaseIn));
    });

    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.0, 0.30),
        end: const Offset(0.0, 0.0),
      ).animate(animation),
      child: child,
    );
  }
}
