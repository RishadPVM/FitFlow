import 'package:get/get.dart';
import 'package:fitflow/routes/app_routes.dart';
import 'package:fitflow/core/services/storage_service.dart';

class AdminProfileController extends GetxController {
  final StorageService _storage = Get.find<StorageService>();

  // final RxString userRole = 'User'.obs; 
  final RxString userName = 'Mark Johnson'.obs;
  final RxString userEmail = 'admin@titanfitness.com'.obs;
  final RxString gymName = 'Titan Fitness Elite'.obs;
  final RxString phone = '+1 (555) 987-6543'.obs;
  final RxString address = '123 Muscle Ave, Fitness City'.obs;
  final RxString workingHours = '06:00 AM - 11:00 PM'.obs;
  final RxString aboutGym = 'Premium fitness center dedicated to strength training and holistic health.'.obs;
  
  // Finance Stats
  final RxString totalRevenue = '\$12,450.00'.obs;
  final RxString monthlyEarnings = '\$4,200.00'.obs;
  final RxString pendingPayments = '\$850.00'.obs;

  // Notification Settings
  final RxBool newMemberAlerts = true.obs;
  final RxBool paymentAlerts = true.obs;
  final RxBool expiryAlerts = false.obs;
  final RxBool pushNotifications = true.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   // _loadProfileData();
  // }

  // void _loadProfileData() {
  //   final role = _storage.read<String>('user_role');
  //   if (role != null) {
  //     userRole.value = role;
  //   }
  // }

  void toggleSetting(RxBool setting) {
    setting.value = !setting.value;
  }

  void logout() {
    _storage.clearAll();
    Get.offAllNamed(AppRoutes.roleSelection);
  }
}
