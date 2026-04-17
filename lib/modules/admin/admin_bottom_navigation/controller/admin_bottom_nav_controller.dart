import 'package:get/get.dart';
import '../../../../core/services/storage_service.dart';
import '../../../../routes/app_routes.dart';

class AdminBottomNavController extends GetxController {
  final StorageService _storage = Get.find<StorageService>();

  final RxInt selectedIndex = 0.obs;

  void changePage(int index) {
    selectedIndex.value = index;
  }

  void logout() {
    _storage.clearAll();
    Get.offAllNamed(AppRoutes.roleSelection);
  }
}
