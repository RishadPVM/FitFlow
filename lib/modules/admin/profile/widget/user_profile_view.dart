// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:fitflow/core/theme/app_colors.dart';
// import 'package:fitflow/core/theme/app_text_styles.dart';
// import '../controller/admin_profile_controller.dart';
// import '../../finance/finance_page.dart';
// import 'shared_components.dart';

// Widget buildUserProfileView(BuildContext context, AdminProfileController controller) {
//   return SingleChildScrollView(
//     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         _buildUserHeaderSection(controller),
//         const SizedBox(height: 24),
//         _buildUserGymDetailsSection(),
//         const SizedBox(height: 24),
//         _buildUserMembershipSection(context),
//         const SizedBox(height: 24),
//         _buildUserEnhancementsSection(),
//         const SizedBox(height: 24),
//         _buildUserAdditionalFeatures(controller),
//         const SizedBox(height: 48), // Bottom padding
//       ],
//     ),
//   );
// }

// Widget _buildUserHeaderSection(AdminProfileController controller) {
//   return buildProfileCard(
//     child: Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Row(
//         children: [
//           CircleAvatar(
//             radius: 40,
//             backgroundColor: AppColors.primaryBlue.withValues(alpha: 0.1),
//             child: const Icon(Icons.person, size: 40, color: AppColors.primaryBlue),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Obx(() => Text(controller.userName.value, style: AppTextStyles.h3)),
//                 const SizedBox(height: 4),
//                 Obx(() => Text(controller.userEmail.value, style: AppTextStyles.bodyMedium)),
//                 const SizedBox(height: 4),
//                 Text('+1 (555) 123-4567', style: AppTextStyles.caption),
//               ],
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.edit_outlined, color: AppColors.primaryBlue),
//             onPressed: () {},
//           ),
//         ],
//       ),
//     ),
//   );
// }

// Widget _buildUserGymDetailsSection() {
//   return buildProfileSection(
//     title: 'Gym Details',
//     children: [
//       buildProfileListTile(icon: Icons.fitness_center, title: 'Joined Gym', subtitle: 'Titan Fitness Elite'),
//       const Divider(height: 1),
//       buildProfileListTile(icon: Icons.assignment_ind_outlined, title: 'Trainer Assigned', subtitle: 'Mark Johnson'),
//       const Divider(height: 1),
//       buildProfileListTile(icon: Icons.list_alt_rounded, title: 'Workout Plan', subtitle: 'Advanced Hypertrophy'),
//     ],
//   );
// }

// Widget _buildUserMembershipSection(BuildContext context) {
//   return buildProfileSection(
//     title: 'Membership & Finance',
//     children: [
//       buildProfileListTile(icon: Icons.stars_rounded, title: 'Current Plan', subtitle: 'Pro Tier (Active)', color: AppColors.primaryBlue),
//       const Divider(height: 1),
//       buildProfileListTile(icon: Icons.upgrade_rounded, title: 'Upgrade / Downgrade Plan'),
//       const Divider(height: 1),
//       buildProfileListTile(
//         icon: Icons.receipt_long_rounded, 
//         title: 'Payment History & Finance',
//         subtitle: 'View past invoices',
//         onTap: () => Get.to(() => const FinancePage()),
//       ),
//     ],
//   );
// }

// Widget _buildUserEnhancementsSection() {
//   return buildProfileSection(
//     title: 'Fitness & Stats',
//     children: [
//       buildProfileListTile(icon: Icons.pie_chart_outline_rounded, title: 'BMI & Fitness Dashboard'),
//       const Divider(height: 1),
//       buildProfileListTile(icon: Icons.emoji_events_outlined, title: 'Achievements & Progress'),
//       const Divider(height: 1),
//       buildProfileListTile(icon: Icons.watch_outlined, title: 'Connected Wearables'),
//       const Divider(height: 1),
//       buildProfileListTile(icon: Icons.calendar_month_outlined, title: 'Attendance History'),
//     ],
//   );
// }

// Widget _buildUserAdditionalFeatures(AdminProfileController controller) {
//   return buildProfileSection(
//     title: 'Settings & More',
//     children: [
//       buildProfileListTile(icon: Icons.notifications_none_rounded, title: 'Notification Settings'),
//       const Divider(height: 1),
//       buildProfileListTile(icon: Icons.dark_mode_outlined, title: 'Dark Mode', trailing: Switch(value: true, onChanged: (val){}, activeColor: AppColors.primaryBlue)),
//       const Divider(height: 1),
//       buildProfileListTile(icon: Icons.language_rounded, title: 'Language Preferences', subtitle: 'English'),
//       const Divider(height: 1),
//       buildProfileListTile(icon: Icons.group_add_outlined, title: 'Invite to Gym / Referral'),
//       const Divider(height: 1),
//       buildProfileListTile(icon: Icons.help_outline_rounded, title: 'Help & Support'),
//       const Divider(height: 1),
//       buildProfileListTile(icon: Icons.description_outlined, title: 'Terms & Privacy Policy'),
//       const Divider(),
//       buildProfileListTile(
//         icon: Icons.logout_rounded, 
//         title: 'Logout', 
//         color: AppColors.error,
//         onTap: controller.logout,
//       ),
//     ],
//   );
// }
