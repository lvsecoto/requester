import 'package:flutter/material.dart';
import 'package:requester/app/theme/theme.dart';

class ContentWidget extends StatelessWidget {
  const ContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchBar(
          hintText: '搜索请求',
          elevation: MaterialStatePropertyAll(4),
        ),
        SizedBox(height: 16),
        Expanded(
          child: Material(
            color: AppTheme.of(context).surfaceContainerLow,
            shape: RoundedRectangleBorder(
             borderRadius:  BorderRadius.circular(20)
            ),
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 16),
              children: [
                ListTile(
                  title: Text('fasdf'),
                ),
                ListTile(
                  title: Text('fasdf'),
                ),
                ListTile(
                  title: Text('fasdf'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
