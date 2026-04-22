import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'admin_profile_controller.dart';

class EditProfileController extends GetxController {
  final AdminProfileController _profileController = Get.find<AdminProfileController>();

  late TextEditingController gymNameController;
  late TextEditingController userNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  late TextEditingController aboutGymController;

  final RxBool is24Hours = false.obs;
  final Rx<TimeOfDay> openTime = const TimeOfDay(hour: 6, minute: 0).obs;
  final Rx<TimeOfDay> closeTime = const TimeOfDay(hour: 23, minute: 0).obs;

  @override
  void onInit() {
    super.onInit();
    gymNameController = TextEditingController(text: _profileController.gymName.value);
    userNameController = TextEditingController(text: _profileController.userName.value);
    emailController = TextEditingController(text: _profileController.userEmail.value);
    phoneController = TextEditingController(text: _profileController.phone.value);
    addressController = TextEditingController(text: _profileController.address.value);
    aboutGymController = TextEditingController(text: _profileController.aboutGym.value);

    _parseWorkingHours(_profileController.workingHours.value);
  }

  void _parseWorkingHours(String hours) {
    if (hours.toLowerCase().contains('24')) {
      is24Hours.value = true;
    } else {
      is24Hours.value = false;
      try {
        final parts = hours.split('-');
        if (parts.length == 2) {
          final openStr = parts[0].trim();
          final closeStr = parts[1].trim();
          
          final DateFormat format = DateFormat("hh:mm a");
          final DateTime openDate = format.parse(openStr);
          final DateTime closeDate = format.parse(closeStr);
          
          openTime.value = TimeOfDay(hour: openDate.hour, minute: openDate.minute);
          closeTime.value = TimeOfDay(hour: closeDate.hour, minute: closeDate.minute);
        }
      } catch (e) {
        // Use defaults
      }
    }
  }

  Future<void> pickTime(BuildContext context, bool isOpenTime) async {
    final initialTime = isOpenTime ? openTime.value : closeTime.value;
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF0052FF), // AppColors.primaryBlue
              onPrimary: Colors.white,
              surface: Color(0xFF1E1E1E), // AppColors.surface
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      if (isOpenTime) {
        openTime.value = pickedTime;
      } else {
        closeTime.value = pickedTime;
      }
    }
  }

  String formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat("hh:mm a").format(dt);
  }

  @override
  void onClose() {
    gymNameController.dispose();
    userNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    aboutGymController.dispose();
    super.onClose();
  }

  void saveProfile() {
    _profileController.gymName.value = gymNameController.text;
    _profileController.userName.value = userNameController.text;
    _profileController.userEmail.value = emailController.text;
    _profileController.phone.value = phoneController.text;
    _profileController.address.value = addressController.text;
    _profileController.aboutGym.value = aboutGymController.text;

    if (is24Hours.value) {
      _profileController.workingHours.value = 'Open 24/7';
    } else {
      _profileController.workingHours.value = '${formatTimeOfDay(openTime.value)} - ${formatTimeOfDay(closeTime.value)}';
    }

    Get.back();
    Get.snackbar(
      'Success',
      'Profile updated successfully',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
