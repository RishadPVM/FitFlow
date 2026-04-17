import 'package:get/get.dart';
import '../../routes/app_routes.dart';
import '../../core/services/storage_service.dart';

class RoleSelectionController extends GetxController {
  final StorageService _storage = Get.find<StorageService>();

  void selectRole(String role) {
    // Usually, you might save the role locally to show a different default later
    _storage.write('last_role', role);

    if (role == 'user') {
      Get.toNamed(AppRoutes.login, arguments: {'role': 'user'});
    } else if (role == 'admin') {
      Get.toNamed(AppRoutes.login, arguments: {'role': 'admin'});
    } else if (role == 'trainer') {
      Get.toNamed(AppRoutes.login, arguments: {'role': 'trainer'});
    }
  }
}
