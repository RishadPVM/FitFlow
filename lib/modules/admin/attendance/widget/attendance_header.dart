import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../controller/attendance_controller.dart';

Widget attendanceHeader(AttendanceController controller) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Attendance", style: AppTextStyles.h3),
          const SizedBox(height: 6),
          Obx(
            () => Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                "${controller.totalPresentCount.value} Present Today",
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.primaryBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),

      // 🔥 SESSION BUTTON
      Row(
        spacing: 10,
        children: [
          Obx(
            () => ElevatedButton(
              onPressed: controller.isSessionActive.value
                  ? controller.stopSession
                  : controller.startSession,
              style: ElevatedButton.styleFrom(
                backgroundColor: controller.isSessionActive.value
                    ? Colors.red
                    : AppColors.primaryBlue,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                controller.isSessionActive.value ? "Stop" : "Start",
                style: AppTextStyles.buttonText.copyWith(color: Colors.white),
              ),
            ),
          ),
          // 🔥 SCREEN LOCK BUTTON
          if (controller.isSessionActive.value)
            Obx(
              () => ElevatedButton(
                onPressed: controller.isScreenLocked.value
                    ? controller.screenUnlock
                    : controller.screenLock,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  controller.isSessionActive.value
                      ? "Screen Lock"
                      : "Screen Unlock",
                  style: AppTextStyles.buttonText.copyWith(color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    ],
  );
}
