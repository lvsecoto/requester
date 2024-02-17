import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:requester/ui/common/common.dart';
import 'package:requester/ui/settings/document/provider/provider.dart'
    as provider;
import 'package:requester/ui/settings/document/widget/actions/action_delete_document_source_widget.dart';
import 'package:requester/ui/settings/document/widget/actions/action_sync_document_source_widget.dart';

class ContentWidget extends ConsumerWidget {
  const ContentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('文档配置'),
        actions: [
          IconButton(
            onPressed: () async {
              final result = await showInputDialog(context,
                  title: const Text('添加文档链接'),
                  hintText: 'swagger 文档链接', validator: (it) {
                try {
                  final uri = Uri.parse(it);
                  if (['http', 'https'].contains(uri.scheme)) {
                    return null;
                  } else {
                    return '请输入网址';
                  }
                } catch (e) {
                  return e.toString();
                }
              });

              if (result != null) {
                provider.actionAddDocumentSource(ref, result);
              }
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          Consumer(builder: (context, ref, _) {
            final listProvider = provider.watchDocumentProvider(ref);
            final sources = ref.watch(listProvider) ?? [];
            return DiffSliverAnimatedList(
              items: sources,
              itemBuilder: (context, source) => ListTile(
                title: Text(source.name),
                subtitle: Text(source.url),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ActionSyncDocumentSourceWidget(source: source),
                    ActionDeleteDocumentSourceWidget(source: source),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
