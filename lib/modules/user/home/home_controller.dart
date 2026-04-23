import 'package:get/get.dart';

class UserHomeController extends GetxController {
  final RxBool isLoading = true.obs;
  final RxString todayWorkout = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadHomeData();
  }

  Future<void> _loadHomeData() async {
    try {
      await Future.delayed(const Duration(seconds: 1)); // Mock loading
      todayWorkout.value = 'Chest & Triceps Focus\n4 Exercises - 45 mins';
    } finally {
      isLoading.value = false;
    }
  }
}
