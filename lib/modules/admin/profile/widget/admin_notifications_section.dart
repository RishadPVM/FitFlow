import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fitflow/core/theme/app_colors.dart';
import '../controller/admin_profile_controller.dart';
import 'shared_components.dart';

Widget buildAdminNotificationsSection(AdminProfileController controller) {
  return buildProfileSection(
    title: 'Notification Settings',
    children: [
      _buildToggleTile(
        title: 'New Member Alerts',
        value: controller.newMemberAlerts,
        onChanged: (val) => controller.toggleSetting(controller.newMemberAlerts),
      ),
      const Divider(height: 1),
      _buildToggleTile(
        title: 'Payment Alerts',
        value: controller.paymentAlerts,
        onChanged: (val) => controller.toggleSetting(controller.paymentAlerts),
      ),
      const Divider(height: 1),
      _buildToggleTile(
        title: 'Expiry Alerts',
        value: controller.expiryAlerts,
        onChanged: (val) => controller.toggleSetting(controller.expiryAlerts),
      ),
      const Divider(height: 1),
      _buildToggleTile(
        title: 'Push Notifications',
        value: controller.pushNotifications,
        onChanged: (val) => controller.toggleSetting(controller.pushNotifications),
      ),
    ],
  );
}

Widget _buildToggleTile({required String title, required RxBool value, required Function(bool) onChanged}) {
  return Obx(() => SwitchListTile(
    title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
    value: value.value,
    onChanged: onChanged,
    activeThumbColor: AppColors.primaryBlue,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
  ));
}
