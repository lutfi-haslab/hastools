import 'package:flutter/material.dart';
import 'package:hastools/components/app_scaffold.dart';

class DetailTodoScreen extends StatelessWidget {
  const DetailTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'My Page',
      enablePullRefresh: true,
      withBottomNavigation: false,
      enableLoadMore: true,
      onRefresh: () async {
        // Handle refresh logic
        await Future.delayed(Duration(seconds: 2));
      },
      onLoadMore: () async {
        // Handle load more logic
        await Future.delayed(Duration(seconds: 2));
      },
      headerRight: IconButton(
        icon: Icon(Icons.settings),
        onPressed: () {
          // Handle header right action
        },
      ),
      child: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Item $index'),
          );
        },
      ),
    );
  }
}
