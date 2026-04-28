import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoalsController extends GetxController {
  // Current Step
  final currentStep = 0.obs;

  // Form Data
  final goalType = ''.obs;
  final fitnessLevel = ''.obs;
  final gender = ''.obs;
  final weight = ''.obs;
  final height = ''.obs;
  final age = ''.obs;

  final location = ''.obs; // Train at Home / Gym
  final equipment = <String>[].obs;

  final daysPerWeek = 3.obs; // 2-6
  final sessionMinutes = 45.obs; // 15-90
  final includeWarmup = true.obs;
  final includeCooldown = true.obs;
  final includeCardio = false.obs;

  final injuries = <String>[].obs;

  // Navigation
  void nextStep() {
    if (_validateCurrentStep()) {
      if (currentStep.value < 6) {
        currentStep.value++;
      }
    }
  }

  void prevStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  bool _validateCurrentStep() {
    switch (currentStep.value) {
      case 0:
        if (goalType.value.isEmpty) {
          Get.snackbar('Required', 'Please select a goal type');
          return false;
        }
        return true;
      case 1:
        if (fitnessLevel.value.isEmpty) {
          Get.snackbar('Required', 'Please select your fitness level');
          return false;
        }
        return true;
      case 2:
        if (gender.value.isEmpty ||
            weight.value.isEmpty ||
            height.value.isEmpty ||
            age.value.isEmpty) {
          Get.snackbar('Required', 'Please fill in all personal metrics');
          return false;
        }
        return true;
      case 3:
        if (location.value.isEmpty) {
          Get.snackbar('Required', 'Please select your training location');
          return false;
        }
        return true;
      case 4:
        return true;
      case 5:
        if (injuries.isEmpty) {
          Get.snackbar(
            'Required',
            'Please select any injuries, or choose "None"',
          );
          return false;
        }
        return true;
      case 6:
        return true;
      default:
        return true;
    }
  }

  void toggleEquipment(String eq) {
    if (equipment.contains(eq)) {
      equipment.remove(eq);
    } else {
      equipment.add(eq);
    }
  }

  void toggleInjury(String inj) {
    if (inj == 'None') {
      injuries.clear();
      injuries.add('None');
      return;
    }
    if (injuries.contains('None')) {
      injuries.remove('None');
    }
    if (injuries.contains(inj)) {
      injuries.remove(inj);
    } else {
      injuries.add(inj);
    }
  }

  Future<void> generatePlan() async {
    // 3 second delay to simulate plan generation
    await Future.delayed(const Duration(seconds: 3));

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_done', true);
    await prefs.setString('user_goal', goalType.value);
    await prefs.setInt('days_per_week', daysPerWeek.value);
    await prefs.setInt('session_minutes', sessionMinutes.value);
    await prefs.setStringList('equipment', equipment.toList());

    Get.snackbar('Success', 'Workout plan generated successfully!');

    // Instead of directly pushing, we will update the navigation if needed,
    // or just let the main page handle the onboardingDone status.
    Get.offAllNamed('/user/dashboard');
  }
}
