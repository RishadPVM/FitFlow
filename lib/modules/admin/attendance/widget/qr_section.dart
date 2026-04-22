import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../controller/attendance_controller.dart';

class QRSection extends GetView<AttendanceController> {
  const QRSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!controller.isSessionActive.value) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              IconButton(
                icon: const Icon(Icons.play_circle),
                iconSize: 60,
                color: Colors.grey,
                onPressed: () => controller.startSession(),
              ),
              const SizedBox(height: 12),
              const Text("Session Stopped"),
            ],
          ),
        );
      }

      final progress = controller.qrCountdown.value / 30;

      return Column(
        children: [
          QRBorderContainer(
            progress: progress,
            child: QrImageView(data: controller.qrData.value, size: 250),
          ),

          const SizedBox(height: 16),

          Text("${controller.qrCountdown.value}s remaining"),

          TextButton(
            onPressed: controller.refreshQrContent,
            child: const Text("Refresh"),
          ),
        ],
      );
    });
  }
}

class QRBorderContainer extends StatelessWidget {
  final double progress;
  final Widget child;

  const QRBorderContainer({
    super.key,
    required this.progress,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _BorderPainter(progress),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryBlue.withValues(alpha: 0.25),
              blurRadius: 40,
              spreadRadius: 4,
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}

class _BorderPainter extends CustomPainter {
  final double progress;

  _BorderPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final radius = 24.0;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rRect = RRect.fromRectAndRadius(rect, Radius.circular(radius));

    // 🔹 Background border
    final bgPaint = Paint()
      ..color = AppColors.primaryBlue.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;

    canvas.drawRRect(rRect, bgPaint);

    // 🔹 Progress border
    final path = Path()..addRRect(rRect);
    final metric = path.computeMetrics().first;

    final progressPath = metric.extractPath(0, metric.length * progress);

    final fgPaint = Paint()
      ..color = AppColors.primaryBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(progressPath, fgPaint);
  }

  @override
  bool shouldRepaint(covariant _BorderPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
