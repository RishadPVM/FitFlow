import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../controller/attendance_controller.dart';

void showManualEntrySheet() {
  final controller = Get.find<AttendanceController>();

  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 🔘 DRAG HANDLE
          Container(
            height: 4,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          const SizedBox(height: 16),

          // 🔹 TITLE
          Text("Manual Attendance", style: AppTextStyles.h3),

          const SizedBox(height: 14),

          // 🔍 SEARCH
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(14),
            ),
            child: TextField(
              onChanged: (val) => controller.searchQuery.value = val,
              decoration: const InputDecoration(
                hintText: "Search member...",
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
              ),
            ),
          ),

          const SizedBox(height: 14),

          // 🔥 MEMBER LIST
          Obx(() {
            final members = controller.filteredMembers;

            if (members.isEmpty) {
              return Column(
                children: const [
                  SizedBox(height: 20),
                  Icon(Icons.search_off, size: 40, color: Colors.grey),
                  SizedBox(height: 8),
                  Text("No members found"),
                ],
              );
            }

            return SizedBox(
              height: 280,
              child: ListView.builder(
                itemCount: members.length,
                itemBuilder: (_, index) {
                  final member = members[index];

                  return GestureDetector(
                    onTap: () => _showReasonDialog(member, controller),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Row(
                        children: [
                          // 👤 AVATAR
                          CircleAvatar(
                            backgroundColor: AppColors.primaryBlue.withValues(alpha: 0.1),
                            child: Text(
                              member.name[0],
                              style: const TextStyle(
                                color: AppColors.primaryBlue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          const SizedBox(width: 12),

                          // 📄 INFO
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  member.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  member.phone,
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),

                          const Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }),
        ],
      ),
    ),
    isScrollControlled: true,
  );
}

// 🔐 PREMIUM DIALOG
void _showReasonDialog(MemberModel member, AttendanceController controller) {
  final reasonController = TextEditingController();

  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Reason", style: AppTextStyles.h3),
          const SizedBox(height: 10),

          TextField(
            controller: reasonController,
            decoration: InputDecoration(
              hintText: "Enter reason...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          const SizedBox(height: 14),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                controller.markPresent(member, reasonController.text.trim());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text("Submit"),
            ),
          ),
        ],
      ),
    ),
  );
}
