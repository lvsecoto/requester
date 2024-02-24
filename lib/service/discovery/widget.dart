part of 'discovery.dart';

class RequesterClientDiscoveryControllerWidget extends HookConsumerWidget {
  /// 用于发现客户端
  const RequesterClientDiscoveryControllerWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useMemoized(() => RequesterClientDiscoveryController(
          ref.read(clientManagerProvider),
        ));
    useAppLifecycleAware(controller);
    return _ClientDiscoveryControllerHolder(
      controller: controller,
      child: child,
    );
  }
}

class _ClientDiscoveryControllerHolder extends InheritedWidget {
  const _ClientDiscoveryControllerHolder({
    required super.child,
    required this.controller,
  });

  final RequesterClientDiscoveryController controller;

  static _ClientDiscoveryControllerHolder _of(BuildContext context) {
    final _ClientDiscoveryControllerHolder? result = context
        .findAncestorWidgetOfExactType<_ClientDiscoveryControllerHolder>();
    assert(
        result != null, 'No _ClientDiscoveryControllerHolder found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_ClientDiscoveryControllerHolder old) {
    return false;
  }
}
