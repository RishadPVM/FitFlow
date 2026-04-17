import 'package:get/get.dart';

import '../services/api_service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Injecting core services globally
    Get.lazyPut<ApiService>(() => ApiService(), fenix: true);
    // Note: StorageService is usually put asynchronously in main.dart prior to app run
    // because it requires Hive initialization. But it's good practice to ensure references here if needed.
  }
}
