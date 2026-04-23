import 'package:flutter/material.dart';
import 'package:fitflow/core/theme/app_colors.dart';
import 'package:fitflow/core/theme/app_text_styles.dart';
import '../controller/admin_profile_controller.dart';
import 'shared_components.dart';

Widget buildAdminSupportSection(BuildContext context, AdminProfileController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildProfileSection(
        title: 'Help & Support',
        children: [
          buildProfileListTile(
            icon: Icons.help_outline_rounded,
            title: 'FAQ Section',
            // color: AppColors.primaryBlue,
            onTap: () {},
          ),
          const Divider(height: 1, color: AppColors.divider),
          buildProfileListTile(
            icon: Icons.support_agent_rounded,
            title: 'Contact Support',
            subtitle: 'Raise a ticket for technical issues',
            // color: AppColors.secondaryGreen,
            onTap: () {},
          ),
        ],
      ),
      const SizedBox(height: 24),
      buildProfileSection(
        title: 'Terms & Privacy',
        children: [
          buildProfileListTile(
            icon: Icons.description_outlined,
            title: 'Terms & Conditions',
            // color: AppColors.textPrimary,
            onTap: () {},
          ),
          const Divider(height: 1, color: AppColors.divider),
          buildProfileListTile(
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy Policy',
            // color: AppColors.textPrimary,
            onTap: () {},
          ),
        ],
      ),
      const SizedBox(height: 32),
      SizedBox(
        width: double.infinity,
        child: InkWell(
          onTap: () => _showLogoutConfirmation(context, controller),
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.error.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.logout_rounded, color: AppColors.error, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Logout',
                  style: AppTextStyles.buttonText.copyWith(
                    color: AppColors.error,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

void _showLogoutConfirmation(BuildContext context, AdminProfileController controller) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: AppColors.background,
      title: const Text('Logout'),
      content: const Text('Are you sure you want to log out of your gym owner account?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel', style: TextStyle(color: AppColors.textSecondary)),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            controller.logout();
          },
          child: const Text('Logout', style: TextStyle(color: AppColors.error, fontWeight: FontWeight.bold)),
        ),
      ],
    ),
  );
}
