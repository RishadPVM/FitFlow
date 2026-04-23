import 'package:fitflow/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/admin_profile_controller.dart';
import 'shared_components.dart';

Widget buildAdminNotificationsSection(AdminProfileController controller) {
  return buildProfileSection(
    title: 'Notification Settings',
    children: [
      _buildToggleTile(
        icon: Icons.person_add_rounded,
        title: 'New Member Alerts',
        value: controller.newMemberAlerts,
        onChanged: (val) =>
            controller.toggleSetting(controller.newMemberAlerts),
      ),
      const Divider(height: 1, color: AppColors.divider),
      _buildToggleTile(
        icon: Icons.payments_rounded,
        title: 'Payment Alerts',
        value: controller.paymentAlerts,
        onChanged: (val) => controller.toggleSetting(controller.paymentAlerts),
      ),
      const Divider(height: 1, color: AppColors.divider),
      _buildToggleTile(
        icon: Icons.event_busy_rounded,
        title: 'Expiry Alerts',
        value: controller.expiryAlerts,
        onChanged: (val) => controller.toggleSetting(controller.expiryAlerts),
      ),
      const Divider(height: 1, color: AppColors.divider),
      _buildToggleTile(
        icon: Icons.notifications_active_rounded,
        title: 'Push Notifications',
        value: controller.pushNotifications,
        onChanged: (val) =>
            controller.toggleSetting(controller.pushNotifications),
      ),
    ],
  );
}

Widget _buildToggleTile({
  required IconData icon,
  required String title,
  // required Color color,
  required RxBool value,
  required Function(bool) onChanged,
}) {
  return Obx(
    () => buildProfileListTile(
      icon: icon,
      title: title,
      // color: color,
      onTap: () => onChanged(!value.value),
      trailing: Switch(
        value: value.value,
        onChanged: onChanged,
        activeThumbColor: AppColors.background,
        activeTrackColor: AppColors.primary,
        inactiveThumbColor: AppColors.textSecondary,
        inactiveTrackColor: AppColors.surfaceLight,
      ),
    ),
  );
}
