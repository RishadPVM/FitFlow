import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../meet/meet_page.dart';
import '../profile/admin_profile_page.dart';
import '../attendance/attendance_page.dart';
import '../overview/overview_page.dart';
import '../users/admin_users_view.dart';
import 'controller/admin_bottom_nav_controller.dart';

class AdminBottomNavigation extends GetView<AdminBottomNavController> {
  const AdminBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => IndexedStack(
            index: controller.selectedIndex.value,
            children: const [
              OverviewPage(),
              AdminUsersView(),
              MeetPage(),
              AttendancePage(),
              AdminProfilePage(),
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
              icon: Icon(Icons.dashboard),
              label: 'Overview',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Members'),
            BottomNavigationBarItem(
              icon: Icon(Icons.handshake_rounded),
              label: 'Meet',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Attendance',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
