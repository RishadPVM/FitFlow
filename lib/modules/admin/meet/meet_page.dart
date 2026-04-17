import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../common/widgets/app_button.dart';
import '../../../common/widgets/app_textfield.dart';
import 'meet_controller.dart';
import 'widgets/meet_list_tile.dart';
import 'widgets/add_gym_dialog.dart';
import 'chat_page.dart';

class MeetPage extends GetView<MeetController> {
  const MeetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gym Network (Meet)', style: AppTextStyles.h2),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          _buildManagementBar(),
          Expanded(
            child: Obx(() {
              final meets = controller.filteredMeets;
              
              if (meets.isEmpty) {
                return _buildEmptyState();
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                itemCount: meets.length,
                itemBuilder: (context, index) {
                  final meet = meets[index];
                  return MeetListTile(
                    meet: meet,
                    onTap: () {
                      controller.openChat(meet);
                      Get.to(() => const ChatPage());
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

  Widget _buildManagementBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
      child: Row(
        children: [
          Expanded(
            child: AppTextField(
              hintText: 'Search chats...',
              prefixIcon: Icons.search,
              onChanged: (val) => controller.searchQuery.value = val,
            ),
          ),
          const SizedBox(width: 16),
          AppButton(
            text: '+ Add Gym',
            onPressed: () {
              Get.bottomSheet(
                const AddGymDialog(),
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
              );
            },
            width: 140, // explicit width for desktop/tablet style
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.handshake_rounded, size: 64, color: AppColors.textSecondary.withValues(alpha: 0.3)),
          const SizedBox(height: 16),
          Text(
            controller.searchQuery.value.isEmpty 
                ? 'No network connections' 
                : 'No chats found', 
            style: AppTextStyles.h3
          ),
          const SizedBox(height: 8),
          Text(
            controller.searchQuery.value.isEmpty 
                ? 'Connect with other gym owners in your area' 
                : 'Try a different search term', 
            style: AppTextStyles.bodyMedium
          ),
        ],
      ),
    );
  }
}
