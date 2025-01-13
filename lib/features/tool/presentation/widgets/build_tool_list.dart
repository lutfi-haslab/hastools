import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hastools/features/tool/data/models/tool_model/index.dart';
import 'package:hastools/features/tool/presentation/bloc/tool_bloc.dart';
import 'package:hastools/features/tool/presentation/widgets/build_tool_card.dart';

Widget buildToolsList(BuildContext context, ToolState state, int lists) {
  if (state is Loading) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: CircularProgressIndicator(),
      ),
    );
  }

  if (state is Loaded) {
    final tools = state.tools;
    late final List<Tool> topTools;

    if (lists == 0) {
      topTools = tools
          .toList(); // Assign the entire list to `topTools` if `lists` is 0
    } else {
      topTools =
          tools.take(lists).toList(); // Take only the specified number of tools
    }

    return Column(
      children: topTools
          .map(
            (tool) => buildToolCard(
              context,
              tool.name,
              tool.imageUrl,
              tool.clickCount,
              tool.path,
              () {
                context.read<ToolBloc>().add(IncrementClick(tool.name));
              },
            ),
          )
          .toList(),
    );
  }

  return const Padding(
    padding: EdgeInsets.all(16.0),
    child: Text('Failed to load tools'),
  );
}
