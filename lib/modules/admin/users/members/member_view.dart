import 'package:fitflow/core/theme/app_colors.dart';
import 'package:fitflow/core/theme/app_text_styles.dart';
import 'package:fitflow/modules/admin/users/members/controller/admin_members_controller.dart';
import 'package:fitflow/modules/admin/users/members/widget/empty_state.dart';
import 'package:fitflow/modules/admin/users/members/widget/member_form.dart';
import 'package:fitflow/modules/admin/users/members/widget/search_filter.dart';
import 'package:fitflow/modules/admin/users/members/widget/members_list_view.dart';
import 'package:fitflow/common/widgets/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MembersContent extends GetView<AdminMembersController> {
  const MembersContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: AppLoader());
      }

      return LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 800;
          return Padding(
            padding: EdgeInsets.all(isMobile ? 16.0 : 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Members',
                          style: isMobile ? AppTextStyles.h3 : AppTextStyles.h2,
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryBlue.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '${controller.totalUsersCount} Total members',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.primaryBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton.icon(
                      onPressed: () => showAddMemberUI(context, isMobile, controller),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 16 : 24,
                          vertical: isMobile ? 12 : 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.person_add_rounded, size: 20),
                      label: Text(
                        'Add Member',
                        style: AppTextStyles.buttonText.copyWith(
                          fontSize: isMobile ? 14 : 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: isMobile ? 20 : 32),
                searchFilterBar(controller, isMobile),
                const SizedBox(height: 24),
                if (controller.filteredUsers.length !=
                    controller.totalUsersCount)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      'Showing ${controller.filteredUsersCount} results',
                      style: AppTextStyles.caption.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                Expanded(
                  child: controller.filteredUsers.isEmpty
                      ? membersEmptyState(controller)
                      : isMobile
                      ? membersMobileView(controller)
                      : membersDesktopView(context, controller),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
