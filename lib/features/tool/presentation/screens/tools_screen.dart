import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hastools/components/app_scaffold.dart';
import 'package:hastools/features/tool/presentation/bloc/tool_bloc.dart';
import 'package:hastools/features/tool/presentation/widgets/build_tool_list.dart';

class ToolsScreen extends StatelessWidget {
  const ToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "List of Tools",
      enablePullRefresh: true,
      withBottomNavigation: false,
      showBackButton: false,
      enableLoadMore: true,
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 2));
      },
      child: BlocBuilder<ToolBloc, ToolState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(16.0),
            child: buildToolsList(context, state, 0),
          );
        },
      ),
    );
  }
}
