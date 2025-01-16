import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hastools/components/app_scaffold.dart';
import 'package:hastools/core/constants/color.dart';
import 'package:hastools/features/tool/presentation/bloc/tool_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget _buildHeader(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.accent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: AppColors.accent,
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(26),
                    child: Image.asset(
                      'assets/workspace.png',
                      width: 52,
                      height: 52,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Welcome to HasTools',
                  style: TextStyle(
                    color: AppColors.accent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 52),
          const Text(
            'Discover Our\nPowerful Tools',
            style: TextStyle(
              fontSize: 36,
              height: 1.2,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'A collection of practical tools for everyday use',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: AppScaffold(
        backExit: true,
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: AppColors.background,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                BlocBuilder<ToolBloc, ToolState>(
                  builder: (context, state) {
                    if (state is Loading) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(24.0),
                          child: CircularProgressIndicator(
                            color: AppColors.accent,
                          ),
                        ),
                      );
                    }

                    if (state is Loaded) {
                      final tools = state.tools;
                      final topTools = tools.take(6).toList();

                      return GridView.builder(
                        padding: EdgeInsets.only(top: 52),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          childAspectRatio: 1.15,
                        ),
                        itemCount: topTools.length,
                        itemBuilder: (context, index) {
                          final tool = topTools[index];
                          return SizedBox(
                            child: _buildToolCard(
                              context,
                              tool.name,
                              tool.imageUrl,
                              tool.path,
                            ),
                          );
                        },
                      );
                    }

                    return const Center(
                      child: Text('Failed to load tools'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToolCard(
    BuildContext context,
    String name,
    String imageUrl,
    String path,
  ) {
    return Container(
      height: 120, // Mengubah tinggi kontainer menjadi 120
      decoration: BoxDecoration(
        color: AppColors.accent,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.08),
            offset: const Offset(0, 8),
            blurRadius: 24,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => context.go(path),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 90,
                  padding: const EdgeInsets.all(1),
                  child: Center(
                    child: imageUrl.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(
                                12), // Menambahkan border radius
                            child: Image.network(
                              imageUrl,
                              fit: BoxFit.contain,
                            ),
                          )
                        : _buildIconPlaceholder(),
                  ),
                ),
                const SizedBox(height: 8), // Mengubah jarak menjadi lebih kecil
                Center(
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16, // Mengubah ukuran font menjadi lebih kecil
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconPlaceholder() {
    return Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: AppColors.accent.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.extension,
        size: 32,
        color: AppColors.accent,
      ),
    );
  }
}
