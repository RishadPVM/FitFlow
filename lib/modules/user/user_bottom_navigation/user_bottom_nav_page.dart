import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../goals/goals_page.dart';
import '../home/user_home_page.dart';
import '../meet/user_meet_page.dart';
import '../profile/profile_page.dart';
import 'user_bottom_nav_controller.dart';

class UserBottomNavPage extends GetView<UserBottomNavController> {
  const UserBottomNavPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => IndexedStack(
            index: controller.selectedIndex.value,
            children: const [
              UserHomePage(),
              UserMeetPage(),
              GoalsPage(),
              UserProfilePage(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: controller.changePage,
          backgroundColor: AppColors.surface,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textSecondary,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_rounded),
              label: 'Meet',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.track_changes_rounded),
              label: 'Goals',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
