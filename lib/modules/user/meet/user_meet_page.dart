import 'package:fitflow/common/widgets/app_textfield.dart';
import 'package:fitflow/modules/admin/meet/widgets/add_gym_dialog.dart';
import 'package:fitflow/modules/admin/meet/widgets/meet_list_tile.dart';
import 'package:fitflow/modules/user/meet/user_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import 'user_meet_controller.dart';

class UserMeetPage extends GetView<UserMeetController> {
  const UserMeetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gym Network (Meet)', style: AppTextStyles.h2),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              style: IconButton.styleFrom(
                backgroundColor: AppColors.surfaceLight,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: AppColors.divider),
                ),
              ),
              icon: const Icon(Icons.add),
              onPressed: () {
                Get.bottomSheet(
                  const AddGymDialog(),
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                );
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: Obx(() {
              final meets = controller.filteredMeets;
              if (meets.isEmpty) {
                return _buildEmptyState();
              }
              return ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                itemCount: meets.length,
                itemBuilder: (context, index) {
                  final meet = meets[index];
                  return MeetListTile(
                    meet: meet,
                    onTap: () {
                      controller.openChat(meet);
                      Get.to(() => const UserChatScreen());
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: AppTextField(
        hintText: 'Search chats...',
        prefixIcon: Icons.search,
        onChanged: (val) => controller.searchQuery.value = val,
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.handshake_rounded,
            size: 64,
            color: AppColors.textSecondary.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 16),
          Text(
            controller.searchQuery.value.isEmpty
                ? 'No network connections'
                : 'No chats found',
            style: AppTextStyles.h3,
          ),
          const SizedBox(height: 8),
          Text(
            controller.searchQuery.value.isEmpty
                ? 'Connect with other gym owners in your area'
                : 'Try a different search term',
            style: AppTextStyles.bodyMedium,
          ),
        ],
      ),
    );
  }
}
