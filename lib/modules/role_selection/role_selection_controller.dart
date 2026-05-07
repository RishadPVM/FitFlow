import 'package:fitflow/core/constants/app_shared_pref_key.dart';
import 'package:fitflow/core/constants/ennum.dart';
import 'package:fitflow/models/gym_model.dart';
import 'package:fitflow/models/trainer_model.dart';
import 'package:fitflow/models/user_model.dart';
import 'package:fitflow/routes/app_routes.dart';
import 'package:fitflow/core/services/global_session.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';



class RoleSelectionController extends GetxController {

    final GlobalSessionController session = Get.find<GlobalSessionController>();


  final RxString highlightedRole = UserRole.user.name.obs;
   final roleKey = AppSharedPrefKey.loginedRole;

  @override
  void onInit() {
    super.onInit();
    _loadLastRole();
  }

  Future<void> _loadLastRole() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final lastRole = prefs.getString(roleKey);
      if (lastRole != null && lastRole.isNotEmpty) {
        await Future.delayed(const Duration(seconds: 3)); // Mock Network       
        final role = UserRole.values.firstWhere((e) => e.name == lastRole);
        session.currentRole.value = role;
        session.isLoggedIn.value = true;

        // Navigate to appropriate dashboard based on role
      switch (role) {
        case UserRole.user:
          session.setUserSession(user: dummyUser,);
          Get.offAllNamed(AppRoutes.userBottomNav);
          break;
        case UserRole.gymOwner:
          session.setGymSession(gym: dummyGym,);
          Get.offAllNamed(AppRoutes.gymOwnerDashboard);
          break;
        case UserRole.trainer:
          session.setTrainerSession(trainer: dummyTrainer,);
          // Get.offAllNamed(AppRoutes.trn);
          Get.snackbar('Trainer', 'Trainer dashboard');
          break;
      }
      }else{
        session.clearSession();
      }
    } catch (e) {
      // Ignored: Default to 'user'
    }
  }

  void selectRole(String roleName) async {
    // highlightedRole.value = roleName;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(roleKey, roleName);
    } catch (e) {
      // Ignored: Continue navigation even if storage fails
    }
    // Small delay to allow the selection animation/ripple to complete
    await Future.delayed(const Duration(milliseconds: 300));

    if (roleName == UserRole.user.name) {
      Get.toNamed(AppRoutes.login, arguments: {'role': UserRole.user.name});
    } else if (roleName == UserRole.gymOwner.name) {
      Get.toNamed(AppRoutes.login, arguments: {'role': UserRole.gymOwner.name});
    } else if (roleName == UserRole.trainer.name) {
      Get.toNamed(AppRoutes.login, arguments: {'role': UserRole.trainer.name});
    }
  }
}
