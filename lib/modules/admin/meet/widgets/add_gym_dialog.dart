import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../common/widgets/app_textfield.dart';
import '../meet_controller.dart';

class AddGymDialog extends GetView<MeetController> {
  const AddGymDialog({super.key});

  @override
  Widget build(BuildContext context) {
    // Reset search query when sheet opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.gymSearchQuery.value = '';
    });

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('New Conversation', style: AppTextStyles.h2),
              IconButton(
                icon: const Icon(Icons.close, color: AppColors.textSecondary),
                onPressed: () => Get.back(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          AppTextField(
            hintText: 'Search network by gym name...',
            prefixIcon: Icons.search,
            onChanged: (val) => controller.gymSearchQuery.value = val,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Obx(() {
              final gyms = controller.filteredAvailableGyms;
              
              if (gyms.isEmpty) {
                return Center(
                  child: Text(
                    'No gyms found in the network.',
                    style: AppTextStyles.bodyMedium,
                  ),
                );
              }

              return ListView.builder(
                itemCount: gyms.length,
                itemBuilder: (context, index) {
                  final gym = gyms[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      backgroundColor: AppColors.primaryBlue.withValues(alpha: 0.1),
                      child: const Icon(Icons.fitness_center, color: AppColors.primaryBlue),
                    ),
                    title: Text(gym.name, style: AppTextStyles.bodyLarge),
                    subtitle: Text(gym.role, style: AppTextStyles.caption),
                    trailing: const Icon(Icons.chat_bubble_outline, color: AppColors.textSecondary),
                    onTap: () {
                      Get.back(); // close sheet
                      controller.startNewChat(gym);
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
}
