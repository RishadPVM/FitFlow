import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../common/widgets/app_loader.dart';
import 'user_dashboard_controller.dart';

import '../../chat/chat_page.dart';
import '../../admin/profile/admin_profile_page.dart';

class UserDashboardPage extends GetView<UserDashboardController> {
  const UserDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() => IndexedStack(
          index: controller.selectedIndex.value,
          children: const [
            _UserHomeContent(),
            ChatListPage(),
            AdminProfilePage(),
          ],
        )),
      ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        currentIndex: controller.selectedIndex.value,
        onTap: controller.changePage,
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primaryBlue,
        unselectedItemColor: AppColors.textSecondary,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_rounded),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      )),
    );
  }
}

class _UserHomeContent extends GetView<UserDashboardController> {
  const _UserHomeContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.appName, style: AppTextStyles.h2),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.todayWorkout.isEmpty) {
          return const Center(child: AppLoader());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Good Morning, Alex!',
                style: AppTextStyles.h2,
              ),
              const SizedBox(height: 32),
              _buildCard(
                title: AppStrings.todayWorkout,
                content: controller.todayWorkout.isEmpty ? 'No workout assigned' : controller.todayWorkout.value,
                icon: Icons.fitness_center,
                color: AppColors.primaryBlue,
              ),
              const SizedBox(height: 16),
              _buildCard(
                title: AppStrings.dietPlan,
                content: 'High Protein / Low Carb',
                icon: Icons.restaurant,
                color: AppColors.secondaryGreen,
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildCard({required String title, required String content, required IconData icon, required Color color}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha:0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.bodyMedium),
                const SizedBox(height: 4),
                Text(content, style: AppTextStyles.h3),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
