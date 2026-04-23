import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

class UserProfileController extends GetxController {
  final RxString name = 'Alex'.obs;
  final RxString email = 'alex@example.com'.obs;

  void logout() {
    Get.offAllNamed(AppRoutes.roleSelection);
  }
}
