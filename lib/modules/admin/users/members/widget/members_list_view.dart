import 'package:fitflow/core/theme/app_colors.dart';
import 'package:fitflow/core/theme/app_text_styles.dart';
import 'package:fitflow/modules/admin/users/members/controller/admin_members_controller.dart';
import 'package:fitflow/modules/admin/users/members/widget/member_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget membersMobileView(AdminMembersController controller) {
  return ListView.builder(
    itemCount: controller.filteredUsers.length,
    padding: const EdgeInsets.only(bottom: 24),
    itemBuilder: (context, index) {
      final user = controller.filteredUsers[index];
      return Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.divider.withValues(alpha: 0.5)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      user.name[0].toUpperCase(),
                      style: const TextStyle(
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(user.email, style: AppTextStyles.caption),
                    ],
                  ),
                ),
                buildStatusChip(user.status),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Divider(height: 1, thickness: 1),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.divider),
                  ),
                  child: Text(
                    user.plan.toUpperCase(),
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.primaryBlue,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                Row(
                  children: [
                    buildCircleAction(
                      icon: Icons.edit_rounded,
                      color: AppColors.primaryBlue,
                      onTap: () => showEditMemberUI(Get.context!, true, user, controller),
                    ),
                    const SizedBox(width: 8),
                    buildCircleAction(
                      icon: Icons.delete_outline_rounded,
                      color: AppColors.error,
                      onTap: () => showDeleteConfirmation(user, controller),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

Widget membersDesktopView(BuildContext context, AdminMembersController controller) {
  return Container(
    decoration: BoxDecoration(
      color: AppColors.surfaceLight,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: AppColors.divider.withValues(alpha: 0.5)),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width - 320,
            ),
            child: DataTable(
              headingRowColor: WidgetStateProperty.all(
                AppColors.background.withValues(alpha: 0.5),
              ),
              headingTextStyle: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
              dataTextStyle: AppTextStyles.bodyMedium,
              dividerThickness: 1,
              columnSpacing: 40,
              horizontalMargin: 24,
              columns: const [
                DataColumn(label: Text('MEMBER')),
                DataColumn(label: Text('EMAIL')),
                DataColumn(label: Text('PLAN')),
                DataColumn(label: Text('STATUS')),
                DataColumn(label: Text('ACTIONS')),
              ],
              rows: controller.filteredUsers.map((user) {
                return DataRow(
                  cells: [
                    DataCell(
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 14,
                            backgroundColor: AppColors.primaryBlue.withValues(
                              alpha: 0.1,
                            ),
                            child: Text(
                              user.name[0],
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryBlue,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            user.name,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    DataCell(Text(user.email)),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryBlue.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          user.plan,
                          style: const TextStyle(
                            color: AppColors.primaryBlue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    DataCell(buildStatusChip(user.status)),
                    DataCell(
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.edit_rounded,
                              color: AppColors.primaryBlue,
                              size: 20,
                            ),
                            onPressed: () => showEditMemberUI(context, false, user, controller),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete_outline_rounded,
                              color: AppColors.error,
                              size: 20,
                            ),
                            onPressed: () => showDeleteConfirmation(user, controller),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget buildCircleAction({
  required IconData icon,
  required Color color,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(20),
    child: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 20),
    ),
  );
}

void showDeleteConfirmation(UserModel user, AdminMembersController controller) {
  Get.dialog(
    AlertDialog(
      backgroundColor: AppColors.background,
      title: const Text('Delete Member'),
      content: Text(
        'Are you sure you want to remove ${user.name}? This action cannot be undone.',
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text(
            'Cancel',
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ),
        TextButton(
          onPressed: () {
            controller.deleteUser(user.id);
            Get.back();
          },
          child: const Text('Delete', style: TextStyle(color: AppColors.error)),
        ),
      ],
    ),
  );
}

Widget buildStatusChip(String status) {
  Color color = status == 'Active' ? AppColors.success : AppColors.error;
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: color.withValues(alpha: 0.5)),
    ),
    child: Text(
      status,
      style: AppTextStyles.caption.copyWith(
        color: color,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
