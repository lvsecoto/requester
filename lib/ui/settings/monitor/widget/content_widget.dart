import 'package:common/common.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:requester/domain/monitor/provider.dart';
import 'package:requester/ui/settings/monitor/provider/provider.dart';

class ContentWidget extends StatelessWidget {
  const ContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('监视器设置'),
      ),
      body: AutoDisposeProviderLoadingStateWidget.multiple(
        futureProvider: [
          monitorHostPortProvider,
        ],
        child: ListView(
          children: [
            Consumer(builder: (context, ref, _) {
              final port = ref.watch(monitorPortProvider) ?? 0;
              final hostPort =
                  ref.watch(monitorHostPortProvider).valueOrNull ?? '';

              return Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    QrImageView(
                      size: 128,
                      data: hostPort,
                      padding: EdgeInsets.zero,
                    ),
                    Expanded(
                      child: DefaultTextStyle(
                        style: Theme.of(context).textTheme.titleMedium!,
                        child: Column(
                          children: [
                            ListTile(
                              onTap: hostPort.isNotEmpty
                                  ? () {
                                      Clipboard.setData(
                                          ClipboardData(text: hostPort));
                                    }
                                  : null,
                              title: const Text('服务连接地址'),
                              subtitle: Text(hostPort),
                            ),
                            ListTile(
                              title: const Text('端口'),
                              subtitle: Text(port.toString()),
                              trailing: IconButton(
                                onPressed: () async {
                                  final port = await showDialog<int>(
                                    context: context,
                                    builder: (context) => HookBuilder(
                                      builder: (context) {
                                        final controller = useTextEditingController();
                                        final error = useState<String?>(null);
                                        return AlertDialog(
                                          title: const Text('请输入端口'),
                                          content: AnimatedSize(
                                            duration: kThemeAnimationDuration,
                                            alignment: Alignment.topCenter,
                                            child: TextField(
                                              controller: controller,
                                              autofocus: true,
                                              decoration: InputDecoration(
                                                hintText: '请输入数字',
                                                errorText: error.value
                                              ),
                                              inputFormatters: [
                                                FilteringTextInputFormatter.digitsOnly,
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('取消'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                final port = controller.text.toIntOrNull();
                                                if (port == null) {
                                                  error.value = '请输入正确的数字';
                                                  return;
                                                }
                                                Navigator.of(context).pop(port);
                                              },
                                              child: const Text('确认'),
                                            ),
                                          ],
                                        );
                                      }
                                    ),
                                  );
                                  if (port != null) {
                                    ref.read(monitorPortProvider.notifier).port = port;
                                  }
                                },
                                icon: const Icon(Icons.edit),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
