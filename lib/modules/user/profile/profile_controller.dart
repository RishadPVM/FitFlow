import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

class UserProfileController extends GetxController {
  final RxString name = 'Alex'.obs;
  final RxString email = 'alex@example.com'.obs;
  final RxInt age = 28.obs;
  final RxString gender = 'Male'.obs;
  final RxString fitnessGoal = 'Build Muscle'.obs;
  
  final RxDouble currentWeight = 78.5.obs;
  final RxDouble targetWeight = 85.0.obs;
  final RxInt streakDays = 12.obs;
  final RxInt consistency = 85.obs;
  
  final RxString fitnessLevel = 'Intermediate'.obs;
  final RxInt daysPerWeek = 4.obs;
  final RxInt sessionDuration = 60.obs;

  void logout() {
    Get.offAllNamed(AppRoutes.roleSelection);
  }
}
