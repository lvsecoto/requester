part of 'log.dart';

class LogServiceControllerWidget extends HookConsumerWidget {

  /// 用于接收日志
  const LogServiceControllerWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(logControllerProvider);
    useAppLifecycleAware(controller);
    return _ControllerHolder(
      controller: controller,
      child: child,
    );
  }
}

class _ControllerHolder extends InheritedWidget {
  const _ControllerHolder({
    required super.child,
    required this.controller,
  });

  final LogServiceController controller;

  static _ControllerHolder _of(BuildContext context) {
    final _ControllerHolder? result = context
        .findAncestorWidgetOfExactType<_ControllerHolder>();
    assert(
        result != null, 'No _ClientDiscoveryControllerHolder found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_ControllerHolder old) {
    return false;
  }
}
