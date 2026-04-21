import 'package:fitflow/modules/admin/meet/widgets/attach_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../meet_controller.dart';

class ChatInputBar extends GetView<MeetController> {
  const ChatInputBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.divider)),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: AppColors.divider.withValues(alpha: 0.5),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller.textController,
                        onChanged: (text) =>
                            controller.isTyping.value = text.isNotEmpty,
                        style: const TextStyle(color: AppColors.textPrimary),
                        minLines: 1,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          hintText: 'Type a message...',
                          hintStyle: TextStyle(color: AppColors.textSecondary),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.attach_file,
                        color: AppColors.textSecondary,
                        size: 20,
                      ),
                      onPressed: () {
                        Get.bottomSheet(
                          backgroundColor: AppColors.surfaceLight,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          attachBottomSheet(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            // Send or Voice Button conditionally rendered
            Obx(() {
              if (controller.isTyping.value) {
                return CircleAvatar(
                  backgroundColor: AppColors.primaryBlue,
                  radius: 24,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 20),
                    onPressed: controller.sendMessage,
                  ),
                );
              }
              return GestureDetector(
                onLongPressStart: (_) => controller.isRecording.value = true,
                onLongPressEnd: (_) => controller.isRecording.value =
                    false, // placeholder for actual record voice logic
                child: Obx(() {
                  final isRec = controller.isRecording.value;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: isRec ? 56 : 48,
                    height: isRec ? 56 : 48,
                    decoration: BoxDecoration(
                      color: isRec ? AppColors.error : AppColors.primary,
                      shape: BoxShape.circle,
                      boxShadow: isRec
                          ? [
                              BoxShadow(
                                color: AppColors.error.withValues(alpha: 0.4),
                                blurRadius: 12,
                                spreadRadius: 4,
                              ),
                            ]
                          : null,
                    ),
                    child: Icon(
                      isRec ? Icons.mic : Icons.mic_none,
                      color: isRec ? Colors.white : AppColors.background,
                    ),
                  );
                }),
              );
            }),
          ],
        ),
      ),
    );
  }
}
