import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import 'meet_controller.dart';
import 'widgets/chat_bubble.dart';
import 'widgets/chat_input_bar.dart';

class ChatPage extends GetView<MeetController> {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.chatMessages.isEmpty) {
                return _buildEmptyChat();
              }
              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemCount: controller.chatMessages.length,
                itemBuilder: (context, index) {
                  final msg = controller.chatMessages[index];
                  return ChatBubble(message: msg);
                },
              );
            }),
          ),
          const ChatInputBar(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 1,
      backgroundColor: AppColors.surface,
      leadingWidth: 40,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Get.back(),
      ),
      title: Obx(() {
        final partner = controller.currentChatPartner.value;
        if (partner == null) return const SizedBox();
        final contact = partner.contact;
        final isOnline = contact.status == 'Online';

        return Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.secondaryGreen.withValues(alpha: 0.1),
              child: Text(
                contact.name[0],
                style: const TextStyle(
                  color: AppColors.secondaryGreen,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    contact.name,
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      if (isOnline) ...[
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.success,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                      ],
                      Text(
                        isOnline ? 'Online' : 'Offline',
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      }),
      actions: [
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert),
          color: AppColors.surfaceLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          onSelected: (value) {
            if (value == 'report') {
              // add report api call
            } else if (value == 'block') {
              // add block api call
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'report',
              child: Row(
                children: const [
                  Icon(Icons.report, size: 20),
                  SizedBox(width: 10),
                  Text("Report"),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'block',
              child: Row(
                children: const [
                  Icon(Icons.block, size: 20),
                  SizedBox(width: 10),
                  Text("Block"),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEmptyChat() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.chat_bubble_outline,
              size: 48,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          Text('No messages yet', style: AppTextStyles.h3),
          const SizedBox(height: 8),
          Text(
            'Say hello to start the conversation!',
            style: AppTextStyles.bodyMedium,
          ),
        ],
      ),
    );
  }
}
