import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:requester_client/requester_client.dart';

@internal
class RequesterClientIdentityWidget extends HookWidget {
  /// Requester客户端识别组件
  const RequesterClientIdentityWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final identityAnimation = _useUpAndDownAnimationController();
    final isIdentityVisible = useListenableSelector(
        identityAnimation, () => identityAnimation.value != 0);
    final controller = RequesterClientController.of(context)!;
    useMemoized(() {
      controller.onIdentity = () {
        identityAnimation.animateTo(
          identityAnimation.upperBound,
          duration: const Duration(milliseconds: 1500),
          curve: const Interval(
            0,
            0.3,
            curve: Curves.fastOutSlowIn,
          ),
        );
      };
    });
    return Stack(
      textDirection: TextDirection.ltr,
      children: [
        child,
        Visibility(
          visible: isIdentityVisible,
          child: Center(
            child: FadeTransition(
              opacity: identityAnimation,
              child: const _Identity(),
            ),
          ),
        ),
      ],
    );
  }

  /// 返回一个每次到达1.0都会回去到0.0的动画控制器
  AnimationController _useUpAndDownAnimationController() {
    final identityAnimation = useAnimationController();
    useEffect(() {
      void onChange(AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          identityAnimation.animateTo(
            identityAnimation.lowerBound,
            duration: const Duration(milliseconds: 120),
          );
        }
      }

      identityAnimation.addStatusListener(onChange);
      return () {
        identityAnimation.removeStatusListener(onChange);
      };
    }, [identityAnimation]);
    return identityAnimation;
  }
}

class _Identity extends HookWidget {
  const _Identity();

  @override
  Widget build(BuildContext context) {
    final clientId = useFuture(RequesterClient.getClientId()).data ?? '';
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.black54,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Text(
          'Requester 客户端($clientId)',
          textDirection: TextDirection.ltr,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontSize: 32,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
