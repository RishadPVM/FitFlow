import 'package:get/get.dart';

import '../../../../core/services/storage_service.dart';

class OverviewController extends GetxController {
  final StorageService _storage = Get.find<StorageService>();

  final RxBool isLoading = true.obs;
  final RxInt totalUsers = 0.obs;
  final RxInt activeSessions = 0.obs;
  final RxString revenue = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadStats();
  }

  Future<void> _loadStats() async {
    // 1. Initial cached fetch
    totalUsers.value = _storage.read<int>('admin_users') ?? 0;
    activeSessions.value = _storage.read<int>('admin_sessions') ?? 0;
    revenue.value = _storage.read<String>('admin_revenue') ?? '\$0';

    if (totalUsers.value > 0) isLoading.value = false;

    // 2. Network sync
    try {
      await Future.delayed(const Duration(seconds: 1)); // Mock fetch
      totalUsers.value = 452;
      activeSessions.value = 34;
      revenue.value = '\$12,450';
      isLoading.value = false;

      // 3. Cache latest
      _storage.write('admin_users', totalUsers.value);
      _storage.write('admin_sessions', activeSessions.value);
      _storage.write('admin_revenue', revenue.value);
    } catch (e) {
      isLoading.value = false;
    }
  }
}
