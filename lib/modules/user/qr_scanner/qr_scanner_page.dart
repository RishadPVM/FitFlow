import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import 'qr_scanner_controller.dart';

class QrScannerPage extends GetView<QrScannerController> {
  const QrScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Scan Gym QR',
          style: AppTextStyles.h2.copyWith(color: Colors.white),
        ),
        actions: [
          Obx(
            () => IconButton(
              icon: Icon(
                controller.isTorchOn.value ? Icons.flash_on : Icons.flash_off,
                color: Colors.white,
              ),
              onPressed: controller.toggleTorch,
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          GetBuilder<QrScannerController>(
            builder: (ctrl) {
              if (!ctrl.hasPermission.value || ctrl.scannerController == null) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              }
              return MobileScanner(
                controller: ctrl.scannerController!,
                onDetect: ctrl.onDetect,
              );
            },
          ),
          _buildOverlay(),
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              decoration: BoxDecoration(
                color: AppColors.surface.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.divider.withValues(alpha: 0.5),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.qr_code_scanner_rounded,
                    color: AppColors.primary,
                    size: 32,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Align QR code within the frame',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Scanning will start automatically',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverlay() {
    return Container(
      decoration: ShapeDecoration(
        shape: QrScannerOverlayShape(
          borderColor: AppColors.primary,
          borderRadius: 24,
          borderLength: 40,
          borderWidth: 8,
          cutOutSize: Get.width * 0.7,
        ),
      ),
    );
  }
}

class QrScannerOverlayShape extends ShapeBorder {
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final double borderLength;
  final double cutOutSize;

  const QrScannerOverlayShape({
    this.borderColor = Colors.white,
    this.borderWidth = 3.0,
    this.borderRadius = 12.0,
    this.borderLength = 20.0,
    this.cutOutSize = 250.0,
  });

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.all(10);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..fillType = PathFillType.evenOdd
      ..addPath(getOuterPath(rect), Offset.zero);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    Path getLeftTopPath(Rect rect) {
      return Path()
        ..moveTo(rect.left, rect.bottom)
        ..lineTo(rect.left, rect.top)
        ..lineTo(rect.right, rect.top);
    }

    return getLeftTopPath(rect)
      ..lineTo(rect.right, rect.bottom)
      ..lineTo(rect.left, rect.bottom)
      ..lineTo(rect.left, rect.top);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    // final width = rect.width;
    // final height = rect.height;

    // final borderOffset = borderWidth / 2;

    final cutOutRect = Rect.fromCenter(
      center: rect.center,
      width: cutOutSize,
      height: cutOutSize,
    );

    final backgroundPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.7)
      ..style = PaintingStyle.fill;

    // final borderPaint = Paint()
    //   ..color = borderColor
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = borderWidth;

    final boxPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..addRect(rect)
      ..addRRect(
        RRect.fromRectAndRadius(cutOutRect, Radius.circular(borderRadius)),
      )
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(path, backgroundPaint);

    // Top left
    canvas.drawPath(
      Path()
        ..moveTo(cutOutRect.left, cutOutRect.top + borderLength)
        ..lineTo(cutOutRect.left, cutOutRect.top + borderRadius)
        ..arcToPoint(
          Offset(cutOutRect.left + borderRadius, cutOutRect.top),
          radius: Radius.circular(borderRadius),
        )
        ..lineTo(cutOutRect.left + borderLength, cutOutRect.top),
      boxPaint,
    );

    // Top right
    canvas.drawPath(
      Path()
        ..moveTo(cutOutRect.right, cutOutRect.top + borderLength)
        ..lineTo(cutOutRect.right, cutOutRect.top + borderRadius)
        ..arcToPoint(
          Offset(cutOutRect.right - borderRadius, cutOutRect.top),
          radius: Radius.circular(borderRadius),
          clockwise: false,
        )
        ..lineTo(cutOutRect.right - borderLength, cutOutRect.top),
      boxPaint,
    );

    // Bottom right
    canvas.drawPath(
      Path()
        ..moveTo(cutOutRect.right, cutOutRect.bottom - borderLength)
        ..lineTo(cutOutRect.right, cutOutRect.bottom - borderRadius)
        ..arcToPoint(
          Offset(cutOutRect.right - borderRadius, cutOutRect.bottom),
          radius: Radius.circular(borderRadius),
        )
        ..lineTo(cutOutRect.right - borderLength, cutOutRect.bottom),
      boxPaint,
    );

    // Bottom left
    canvas.drawPath(
      Path()
        ..moveTo(cutOutRect.left, cutOutRect.bottom - borderLength)
        ..lineTo(cutOutRect.left, cutOutRect.bottom - borderRadius)
        ..arcToPoint(
          Offset(cutOutRect.left + borderRadius, cutOutRect.bottom),
          radius: Radius.circular(borderRadius),
          clockwise: false,
        )
        ..lineTo(cutOutRect.left + borderLength, cutOutRect.bottom),
      boxPaint,
    );
  }

  @override
  ShapeBorder scale(double t) {
    return QrScannerOverlayShape(
      borderColor: borderColor,
      borderWidth: borderWidth * t,
      borderRadius: borderRadius * t,
      borderLength: borderLength * t,
      cutOutSize: cutOutSize * t,
    );
  }
}
