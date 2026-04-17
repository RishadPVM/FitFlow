import 'package:fitflow/common/widgets/app_button.dart';
import 'package:fitflow/common/widgets/app_textfield.dart';
import 'package:fitflow/core/theme/app_colors.dart';
import 'package:fitflow/core/theme/app_text_styles.dart';
import 'package:fitflow/modules/admin/users/members/controller/admin_members_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showAddMemberUI(
  BuildContext context,
  bool isMobile,
  AdminMembersController controller,
) {
  _showMemberForm(context, isMobile, null, controller);
}

void showEditMemberUI(
  BuildContext context,
  bool isMobile,
  UserModel user,
  AdminMembersController controller,
) {
  _showMemberForm(context, isMobile, user, controller);
}

void _showMemberForm(
  BuildContext context,
  bool isMobile,
  UserModel? user,
  AdminMembersController controller,
) {
  final bool isEdit = user != null;
  final nameController = TextEditingController(text: user?.name);
  final emailController = TextEditingController(text: user?.email);
  String selectedPlan = user?.plan ?? 'Pro';
  String selectedStatus = user?.status ?? 'Active';

  Widget formContent = Container(
    padding: const EdgeInsets.all(24),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isEdit ? 'Edit Member' : 'Add New Member',
          style: AppTextStyles.h3,
        ),
        const SizedBox(height: 24),
        AppTextField(
          hintText: 'Full Name',
          controller: nameController,
          prefixIcon: Icons.person_outline,
        ),
        const SizedBox(height: 16),
        AppTextField(
          hintText: 'Email Address',
          controller: emailController,
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Membership Plan', style: AppTextStyles.caption),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    initialValue: selectedPlan,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    items:
                        ['Basic', 'Pro', 'Elite'].map((plan) {
                          return DropdownMenuItem(
                            value: plan,
                            child: Text(plan),
                          );
                        }).toList(),
                    onChanged: (val) => selectedPlan = val!,
                  ),
                ],
              ),
            ),
            if (isEdit) ...[
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Status', style: AppTextStyles.caption),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      initialValue: selectedStatus,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      items:
                          ['Active', 'Expired'].map((status) {
                            return DropdownMenuItem(
                              value: status,
                              child: Text(status),
                            );
                          }).toList(),
                      onChanged: (val) => selectedStatus = val!,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 32),
        AppButton(
          text: isEdit ? 'Update Member' : 'Create Member',
          onPressed: () {
            if (nameController.text.isNotEmpty &&
                emailController.text.isNotEmpty) {
              if (isEdit) {
                controller.updateUser(
                  user.copyWith(
                    name: nameController.text,
                    email: emailController.text,
                    plan: selectedPlan,
                    status: selectedStatus,
                  ),
                );
              } else {
                controller.addUser(
                  nameController.text,
                  emailController.text,
                  selectedPlan,
                );
              }
            } else {
              Get.snackbar('Error', 'Please fill all fields');
            }
          },
        ),
      ],
    ),
  );

  if (isMobile) {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SingleChildScrollView(child: formContent),
      ),
      isScrollControlled: true,
    );
  } else {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: SizedBox(width: 450, child: formContent),
      ),
    );
  }
}
