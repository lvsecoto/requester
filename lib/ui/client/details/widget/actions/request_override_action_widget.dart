import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RequestOverrideActionWidget extends StatelessWidget {

  /// 请求重载按钮
  const RequestOverrideActionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        var uri = GoRouterState.of(context).uri;
        uri = uri.replace(
          pathSegments: [...uri.pathSegments, 'requestOverride'],
          queryParameters: {
            ...uri.queryParameters,
          },
        );
        GoRouter.of(context).go('/$uri');
      },
      icon: const Icon(Icons.flash_on),
    );
  }
}
