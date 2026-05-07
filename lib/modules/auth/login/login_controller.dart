import 'package:fitflow/core/constants/ennum.dart';
import 'package:fitflow/models/gym_model.dart';
import 'package:fitflow/models/trainer_model.dart';
import 'package:fitflow/models/user_model.dart';
import 'package:fitflow/routes/app_routes.dart';
// import 'package:fitflow/core/services/global_session.dart';
import 'package:fitflow/core/services/global_session.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {

  final GlobalSessionController session = Get.find<GlobalSessionController>();

  final RxString currentRole = ''.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args['role'] != null) {
      currentRole.value = args['role'];
    }
  }

  Future<void> signIn() async {
    isLoading.value = true;
    try {
      if (currentRole.value == UserRole.user.name) {
        try {
           session.setUserSession(user: dummyUser,);
           session.isLoggedIn.value = true;
           session.currentRole.value = UserRole.user;
            
        } catch (e) {
          session.clearSession();
        }
        await Future.delayed(const Duration(seconds: 1)); // Mock Network
        // await _storage.write('token', 'user_mock_token');
        Get.offAllNamed(AppRoutes.userBottomNav);
      } else if (currentRole.value == UserRole.gymOwner.name) {
        await Future.delayed(const Duration(seconds: 1)); // Mock Network
          session.setGymSession(gym: dummyGym,);
           session.isLoggedIn.value = true;
           session.currentRole.value = UserRole.gymOwner;
        Get.offAllNamed(AppRoutes.gymOwnerDashboard);
      } else if (currentRole.value == UserRole.trainer.name) {
        // Trainer route
        await Future.delayed(const Duration(seconds: 1)); // Mock Network
           session.setTrainerSession(trainer: dummyTrainer,);
           session.isLoggedIn.value = true;
           session.currentRole.value = UserRole.trainer;
        // Get.offAllNamed(AppRoutes.train);
      }
    } finally {
      isLoading.value = false;
    }
  }
}
