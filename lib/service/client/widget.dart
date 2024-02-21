part of 'client.dart';

class RequesterClientServiceControllerWidget extends HookWidget {

  /// 套在组件上，和Requester Client通信
  const RequesterClientServiceControllerWidget({
    super.key,
    required this.hostPort,
    required this.child,
  });

  final Widget child;
  final HostPort hostPort;

  @override
  Widget build(BuildContext context) {
    final controller =
        useMemoized(() => RequesterClientServiceController(hostPort: hostPort));
    useAppLifecycleAware(controller);
    useEffect(() {
      return () {
        controller.dispose();
      };
    }, [controller]);
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

  final RequesterClientServiceController controller;

  static RequesterClientServiceController _of(BuildContext context) {
    final _ControllerHolder? result =
        context.findAncestorWidgetOfExactType<_ControllerHolder>();
    assert(
        result != null, 'No _ClientDiscoveryControllerHolder found in context');
    return result!.controller;
  }

  @override
  bool updateShouldNotify(_ControllerHolder old) {
    return false;
  }
}
