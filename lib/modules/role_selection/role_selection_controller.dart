import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../routes/app_routes.dart';

class RoleItem {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final String ctaText;

  RoleItem({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.ctaText,
  });
}

class RoleSelectionController extends GetxController {
  final RxString highlightedRole = 'user'.obs;
  final RxInt currentIndex = 0.obs;
  late PageController pageController;
  
  static const String _roleKey = 'last_selected_role';

  final List<RoleItem> roles = [
    RoleItem(
      id: 'user',
      title: "I'm a User",
      description: "Track workouts, follow personalized plans, and monitor your progress over time.",
      icon: Icons.person_rounded,
      ctaText: "Start My Journey",
    ),
    RoleItem(
      id: 'admin',
      title: "I Own a Gym",
      description: "Manage members, track payments, control trainers, and oversee your entire business.",
      icon: Icons.storefront_rounded,
      ctaText: "Manage My Gym",
    ),
    RoleItem(
      id: 'trainer',
      title: "I'm a Trainer",
      description: "Assign workouts, track client performance, and monitor their progress seamlessly.",
      icon: Icons.sports_rounded,
      ctaText: "Start Training",
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(viewportFraction: 0.8, initialPage: 0);
    _loadLastRole();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  Future<void> _loadLastRole() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final lastRole = prefs.getString(_roleKey);
      if (lastRole != null && lastRole.isNotEmpty) {
        highlightedRole.value = lastRole;
        final index = roles.indexWhere((r) => r.id == lastRole);
        if (index != -1) {
          currentIndex.value = index;
          // Wait for build to complete before animating
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (pageController.hasClients) {
              pageController.jumpToPage(index);
            }
          });
        }
      }
    } catch (e) {
      // Ignored: Default to 'user'
    }
  }

  void onPageChanged(int index) {
    currentIndex.value = index;
    highlightedRole.value = roles[index].id;
  }

  void selectRole(String role) async {
    highlightedRole.value = role;
    
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_roleKey, role);
    } catch (e) {
      // Ignored: Continue navigation even if storage fails
    }

    // Small delay to allow the selection animation/ripple to complete
    await Future.delayed(const Duration(milliseconds: 300));

    if (role == 'user') {
      Get.toNamed(AppRoutes.login, arguments: {'role': 'user'});
    } else if (role == 'admin') {
      Get.toNamed(AppRoutes.login, arguments: {'role': 'admin'});
    } else if (role == 'trainer') {
      Get.toNamed(AppRoutes.login, arguments: {'role': 'trainer'});
    }
  }
}
