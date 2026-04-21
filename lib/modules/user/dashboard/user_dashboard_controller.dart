import 'package:get/get.dart';
// import '../../../core/services/api_service.dart';
import '../../../core/services/storage_service.dart';
import '../../../routes/app_routes.dart';

class UserDashboardController extends GetxController {
  // final ApiService _api = Get.find<ApiService>();
  // final StorageService _storage = Get.find<StorageService>();

  final RxBool isLoading = true.obs;
  final RxString todayWorkout = ''.obs;
  final RxInt selectedIndex = 0.obs;

  void changePage(int index) {
    selectedIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    // 1. Load from cache first
    // final cachedWorkout = _storage.read<String>('today_workout');
    // if (cachedWorkout != null) {
    //   todayWorkout.value = cachedWorkout;
    //   isLoading.value = false;
    // }

    // 2. Fetch from API in background mapping to offline-first pattern
    try {
      // Mocking API delay
      await Future.delayed(const Duration(seconds: 2));
      final apiData = 'Chest & Triceps Focus\n4 Exercises - 45 mins';
      
      // 3. Update state
      todayWorkout.value = apiData;
      isLoading.value = false;
      
      // 4. Save to cache
      // _storage.write('today_workout', apiData);
    } catch (e) {
      // Fallback silently or show generic toast
      isLoading.value = false;
    }
  }

  void logout() {
    // _storage.clearAll();
    Get.offAllNamed(AppRoutes.roleSelection);
  }
}
