import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import 'controller/admin_profile_controller.dart';
import 'widget/admin_finance_section.dart';
import 'widget/admin_invite_section.dart';
import 'widget/admin_notifications_section.dart';
import 'widget/admin_plans_section.dart';
import 'widget/admin_profile_header.dart';
import 'widget/admin_support_section.dart';

class AdminProfilePage extends GetView<AdminProfileController> {
  const AdminProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Profile', style: AppTextStyles.h2),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Obx(() {
        return _buildAdminProfile(context);
      }),
    );
  }

  Widget _buildAdminProfile(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildAdminProfileHeader(controller),
          const SizedBox(height: 24),
          buildAdminMembershipSection(),
          const SizedBox(height: 24),
          buildAdminFinanceSection(context, controller),
          const SizedBox(height: 24),
          buildAdminNotificationsSection(controller),
          const SizedBox(height: 24),
          buildAdminInviteSection(),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 24),
          buildAdminSupportSection(context, controller),
          const SizedBox(height: 48),
        ],
      ),
    );
  }
}
