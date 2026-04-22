// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../../core/theme/app_colors.dart';
// import '../../../../../core/theme/app_text_styles.dart';
// import '../controller/membership_plan_controller.dart';

// class QuickStatsSection extends GetView<MembershipPlanController> {
//   const QuickStatsSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: Row(
//         children: [
//           Expanded(
//             child: _buildStatCard(
//               title: 'Total Plans',
//               valueRx: () => controller.totalPlans.toString(),
//               icon: Icons.list_alt,
//               color: AppColors.primaryBlue,
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: _buildStatCard(
//               title: 'Active Plans',
//               valueRx: () => controller.activePlans.toString(),
//               icon: Icons.check_circle_outline,
//               color: AppColors.secondaryGreen,
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: _buildStatCard(
//               title: 'Total Revenue',
//               valueRx: () => '₹${_formatRevenue(controller.totalRevenue)}',
//               icon: Icons.account_balance_wallet_outlined,
//               color: AppColors.warning,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildStatCard({
//     required String title,
//     required String Function() valueRx,
//     required IconData icon,
//     required Color color,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: AppColors.surfaceLight,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: AppColors.divider, width: 1),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(6),
//                 decoration: BoxDecoration(
//                   color: color.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Icon(icon, color: color, size: 18),
//               ),
//               const SizedBox(width: 8),
//               Expanded(
//                 child: Text(
//                   title,
//                   style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           Obx(
//             () => Text(
//               valueRx(),
//               style: AppTextStyles.h3.copyWith(fontWeight: FontWeight.bold),
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   String _formatRevenue(double value) {
//     if (value >= 10000000) {
//       return '${(value / 10000000).toStringAsFixed(1)}Cr';
//     } else if (value >= 100000) {
//       return '${(value / 100000).toStringAsFixed(1)}L';
//     } else if (value >= 1000) {
//       return '${(value / 1000).toStringAsFixed(1)}K';
//     }
//     return value.toStringAsFixed(0);
//   }
// }
