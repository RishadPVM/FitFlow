import 'package:fitflow/model/user_model.dart';
import 'package:get/get.dart';

import '../../../../../core/theme/app_colors.dart';


class AdminMembersController extends GetxController {
  final isLoading = true.obs;
  final users = <UserModel>[].obs;

  // Search and Filter state
  final searchQuery = ''.obs;
  final statusFilter = 'All'.obs;
  final planFilter = 'All'.obs;

  //  Membership plan state
  final membershipPlans = <String>['Basic', 'Pro', 'Elite'].obs;
  final selectedMembershipPlan = 'Basic'.obs;

  // Member status
  final List<String> memberStatus = ['Active', 'Expired'];

  // QR Code state
  final joinMemberQrCode = '1234567890'.obs;

  // Filtered list
  List<UserModel> get filteredUsers {
    return users.where((user) {
      final matchesSearch =
          user.name.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
          user.email.toLowerCase().contains(searchQuery.value.toLowerCase());
      final matchesStatus =
          statusFilter.value == 'All' || user.status == statusFilter.value;
      final matchesPlan =
          planFilter.value == 'All' || user.plan == planFilter.value;

      return matchesSearch && matchesStatus && matchesPlan;
    }).toList();
  }

  int get totalUsersCount => users.length;
  int get filteredUsersCount => filteredUsers.length;

  @override
  void onInit() {
    super.onInit();
    _loadUsers();
  }

  void _loadUsers() async {
    isLoading.value = true;
    try {
      // Mock network fetch
      await Future.delayed(const Duration(milliseconds: 800));

      users.value = [
        UserModel(
          id: '1',
          name: 'John Doe',
          email: 'john@example.com',
          plan: 'Pro',
          status: 'Active',
        ),
        UserModel(
          id: '2',
          name: 'Jane Smith',
          email: 'jane@example.com',
          plan: 'Basic',
          status: 'Expired',
        ),
        UserModel(
          id: '3',
          name: 'Mike Ross',
          email: 'mike@example.com',
          plan: 'Elite',
          status: 'Active',
        ),
        UserModel(
          id: '4',
          name: 'Rachel Zane',
          email: 'rachel@example.com',
          plan: 'Basic',
          status: 'Active',
        ),
        UserModel(
          id: '5',
          name: 'Harvey Specter',
          email: 'harvey@example.com',
          plan: 'Elite',
          status: 'Active',
        ),
      ];
    } finally {
      isLoading.value = false;
    }
  }

  void updateUser(UserModel updatedUser) {
    final index = users.indexWhere((u) => u.id == updatedUser.id);
    if (index != -1) {
      users[index] = updatedUser;
      Get.back();
      Get.snackbar(
        'Success',
        'Member updated successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.success.withValues(alpha: 0.1),
        colorText: AppColors.success,
      );
    }
  }

  void deleteUser(String id) {
    users.removeWhere((u) => u.id == id);
    Get.snackbar(
      'Success',
      'User removed successfully.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
