import 'package:fitflow/modules/role_selection/role_selection_controller.dart';
import 'package:fitflow/routes/app_routes.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  // final StorageService _storage = Get.find<StorageService>();

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
        // Example: Google Sign In
        try {
          // final GoogleSignInAccount? account = await _googleSignIn.signIn();
          // print(account);
        } catch (e) {
          // Fallback or Handle cancel
        }
        await Future.delayed(const Duration(seconds: 1)); // Mock Network
        // await _storage.write('token', 'user_mock_token');
        Get.offAllNamed(AppRoutes.userBottomNav);
      } else if (currentRole.value == UserRole.admin.name) {
        await Future.delayed(const Duration(seconds: 1)); // Mock Network
        // await _storage.write('token', 'admin_mock_token');
        Get.offAllNamed(AppRoutes.adminDashboard);
      } else if (currentRole.value == UserRole.trainer.name) {
        // Trainer route
        await Future.delayed(const Duration(seconds: 1)); // Mock Network
        Get.back(); // Mock return
      }
    } finally {
      isLoading.value = false;
    }
  }
}
