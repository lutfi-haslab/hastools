import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hastools/core/constants/color.dart';
import 'package:hastools/features/tool/presentation/bloc/tool_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 32,
                backgroundImage: NetworkImage(
                    'https://dummyimage.com/600x400/bdbdbd/ffffff.png'),
              ),
              const SizedBox(height: 24),
              const Text(
                'Profile',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              _buildSection('Hobbies', _buildHobbiesGrid()),
              const SizedBox(height: 32),
              _buildSection('Bio', _buildBio()),
              const SizedBox(height: 32),
              _buildSection('Details', _buildDetails()),
              const SizedBox(height: 32),
              _buildEditButton(),
              const SizedBox(height: 32),
              _buildResetButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        content,
      ],
    );
  }

  Widget _buildHobbiesGrid() {
    final hobbies = [
      ['Climbing', Icons.landscape],
      ['Website Design', Icons.desktop_windows],
      ['Art', Icons.palette],
      ['Hiking', Icons.backpack],
      ['Movies', Icons.movie],
      ['Cooking', Icons.restaurant],
      ['Dogs', Icons.pets],
      ['Roadtrip', Icons.directions_car],
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: hobbies
          .map((hobby) =>
              _buildHobbyChip(hobby[0] as String, hobby[1] as IconData))
          .toList(),
    );
  }

  Widget _buildHobbyChip(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.textPrimary, size: 18),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBio() {
    return const Text(
      'Futuristic dreamer. Software engineer at Netflix. Dog lover.',
      style: TextStyle(
        color: AppColors.textPrimary,
        fontSize: 16,
        height: 1.5,
      ),
    );
  }

  Widget _buildDetails() {
    final details = [
      ['Lives in San Francisco, California', Icons.home],
      ['Engaged', Icons.favorite],
      ['Works at Netflix', Icons.work],
    ];

    return Column(
      children: details
          .map((detail) =>
              _buildDetailItem(detail[0] as String, detail[1] as IconData))
          .toList(),
    );
  }

  Widget _buildDetailItem(String text, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.textPrimary),
          const SizedBox(width: 16),
          Text(
            text,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Text(
        'Edit Profile',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildResetButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Tambahkan logika untuk mereset penyimpanan di sini
        context.read<ToolBloc>().add(ResetTools());
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text(
          'Reset Storage',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
