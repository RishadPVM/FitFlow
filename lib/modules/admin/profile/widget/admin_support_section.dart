import 'package:flutter/material.dart';
import 'package:fitflow/core/theme/app_colors.dart';
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
            onTap: () {},
          ),
          const Divider(height: 1),
          buildProfileListTile(
            icon: Icons.support_agent_rounded,
            title: 'Contact Support',
            subtitle: 'Raise a ticket for technical issues',
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
            onTap: () {},
          ),
          const Divider(height: 1),
          buildProfileListTile(
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy Policy',
            onTap: () {},
          ),
        ],
      ),
      const SizedBox(height: 32),
      SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () => _showLogoutConfirmation(context, controller),
          icon: const Icon(Icons.logout_rounded, size: 20),
          label: const Text('Logout'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.error,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 0,
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
