import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:requester/app/theme/theme.dart';
import 'package:requester/domain/log/log.dart';
import 'package:requester/ui/common/app_state_widget.dart';
import 'package:requester/ui/common/time.dart';

class LogAppStateItemWidget extends StatelessWidget {

  /// App状态条目
  const LogAppStateItemWidget({
    super.key,
    required this.logAppState,
  });

  final LogAppState logAppState;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          AppStateWidget(
            appState: logAppState.state,
          ),
          const Gap(12),
          Text(
            logAppState.time.toHumanReadable(),
            style: Theme.of(context).textTheme.labelMedium!.disabled,
          ),
        ],
      ),
    );
  }
}
