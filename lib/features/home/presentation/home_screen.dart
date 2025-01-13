import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hastools/components/app_scaffold.dart';
import 'package:hastools/core/constants/color.dart';
import 'package:hastools/features/tool/presentation/bloc/tool_bloc.dart';
import 'package:hastools/features/tool/presentation/widgets/build_tool_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: AppColors.accent,
              child: Image.asset('assets/workspace.png'),
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Text(
          'HasTools',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const Text(
          'A collection of practical tools for everyday use',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Tools',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            TextButton(
              onPressed: () {
                // Action for the button can be defined here
                context.go("/tools");
              },
              child: const Text(
                'See All',
                style: TextStyle(
                  color: AppColors.accent,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            BlocBuilder<ToolBloc, ToolState>(
              builder: (context, state) {
                return buildToolsList(context, state, 3);
              },
            ),
          ],
        ),
      ),
    );
  }
}
