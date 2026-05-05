import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../routes/app_routes.dart';

// class RoleItem {
//   final String id;
//   final String title;
//   // final String description;
//   final IconData icon;
//   final String ctaText;

//   RoleItem({
//     required this.id,
//     required this.title,
//     // required this.description,
//     required this.icon,
//     required this.ctaText,
//   });
// }

enum UserRole { user, admin, trainer }

class RoleSelectionController extends GetxController {
  final RxString highlightedRole = UserRole.user.name.obs;

  static const String _roleKey = 'last_selected_role';

  // final List<RoleItem> roles = [
  //   RoleItem(
  //     id: 'user',
  //     title: "I'm a User",
  //     // description: "Track workouts, follow personalized plans, and monitor your progress over time.",
  //     icon: Icons.person_rounded,
  //     ctaText: "Start My Journey",
  //   ),
  //   RoleItem(
  //     id: 'admin',
  //     title: "I Own a Gym",
  //     // description: "Manage members, track payments, control trainers, and oversee your entire business.",
  //     icon: Icons.storefront_rounded,
  //     ctaText: "Manage My Gym",
  //   ),
  //   RoleItem(
  //     id: 'trainer',
  //     title: "I'm a Trainer",
  //     // description: "Assign workouts, track client performance, and monitor their progress seamlessly.",
  //     icon: Icons.sports_rounded,
  //     ctaText: "Start Training",
  //   ),
  // ];

  @override
  void onInit() {
    super.onInit();
    _loadLastRole();
  }

  Future<void> _loadLastRole() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final lastRole = prefs.getString(_roleKey);
      if (lastRole != null && lastRole.isNotEmpty) {
        highlightedRole.value = lastRole;
      }
    } catch (e) {
      // Ignored: Default to 'user'
    }
  }

  void selectRole(String roleName) async {
    highlightedRole.value = roleName;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_roleKey, roleName);
    } catch (e) {
      // Ignored: Continue navigation even if storage fails
    }
    // Small delay to allow the selection animation/ripple to complete
    await Future.delayed(const Duration(milliseconds: 300));

    if (roleName == UserRole.user.name) {
      Get.toNamed(AppRoutes.login, arguments: {'role': UserRole.user.name});
    } else if (roleName == UserRole.admin.name) {
      Get.toNamed(AppRoutes.login, arguments: {'role': UserRole.admin.name});
    } else if (roleName == UserRole.trainer.name) {
      Get.toNamed(AppRoutes.login, arguments: {'role': UserRole.trainer.name});
    }
  }
}
