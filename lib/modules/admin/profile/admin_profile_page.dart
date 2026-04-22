import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import 'controller/admin_profile_controller.dart';
import 'widget/admin_account_section.dart';
import 'widget/admin_notifications_section.dart';
import 'widget/admin_profile_header.dart';
import 'widget/admin_support_section.dart';

class AdminProfilePage extends GetView<AdminProfileController> {
  const AdminProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(child: _buildAdminProfile(context)),
    );
  }

  Widget _buildAdminProfile(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Profile & Settings',
            style: AppTextStyles.h1.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 24),
          buildAdminProfileHeader(controller),
          const SizedBox(height: 32),
          buildAdminAccountManagementSection(context, controller),
          const SizedBox(height: 32),
          buildAdminNotificationsSection(controller),
          const SizedBox(height: 32),
          buildAdminSupportSection(context, controller),
        ],
      ),
    );
  }
}
