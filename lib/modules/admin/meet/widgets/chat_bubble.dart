import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

import '../models/meet_models.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSentByMe = message.isSentByMe;
    final String type = message.type;
    final String time = message.time;

    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75, // Max 75% screen width
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSentByMe ? AppColors.primaryBlue : AppColors.surfaceLight,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(isSentByMe ? 20 : 4),
            bottomRight: Radius.circular(isSentByMe ? 4 : 20),
          ),
          border: isSentByMe 
            ? null 
            : Border.all(color: AppColors.divider.withValues(alpha: 0.5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (type == 'text')
              Text(
                message.text,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: isSentByMe ? Colors.white : AppColors.textPrimary,
                ),
              ),
            if (type == 'voice')
              _buildVoiceMessage(context, isSentByMe, message.duration),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 10,
                    color: isSentByMe ? Colors.white.withValues(alpha: 0.7) : AppColors.textSecondary,
                  ),
                ),
                if (isSentByMe) ...[
                  const SizedBox(width: 4),
                  Icon(
                    Icons.done_all,
                    size: 14,
                    color: Colors.white.withValues(alpha: 0.7), // Add read receipt dummy indicator
                  ),
                ]
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVoiceMessage(BuildContext context, bool isSentByMe, String duration) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.play_arrow_rounded,
          color: isSentByMe ? Colors.white : AppColors.primaryBlue,
          size: 28,
        ),
        const SizedBox(width: 8),
        // Dummy waveform graphic
        SizedBox(
          width: 80,
          height: 24,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(12, (index) {
              return Container(
                width: 3,
                height: [8.0, 16.0, 12.0, 24.0, 10.0, 18.0, 22.0, 14.0, 8.0, 12.0, 18.0, 10.0][index],
                decoration: BoxDecoration(
                  color: isSentByMe ? Colors.white.withValues(alpha: 0.6) : AppColors.primaryBlue.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(2),
                ),
              );
            }),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          duration,
          style: AppTextStyles.caption.copyWith(
            color: isSentByMe ? Colors.white : AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
