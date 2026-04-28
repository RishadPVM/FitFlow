import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/app_colors.dart';

class _AppLoaderController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController mainController;
  late Animation<double> rotationAnim;
  late Animation<double> scaleAnim;
  late Animation<double> pulseScaleAnim;
  late Animation<double> pulseOpacityAnim;

  @override
  void onInit() {
    super.onInit();
    mainController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();

    rotationAnim = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: mainController, curve: Curves.linear));

    scaleAnim = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0.85,
          end: 1.15,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.15,
          end: 0.85,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
    ]).animate(mainController);

    pulseScaleAnim = Tween<double>(
      begin: 0.8,
      end: 1.4,
    ).animate(CurvedAnimation(parent: mainController, curve: Curves.easeOut));

    pulseOpacityAnim = Tween<double>(
      begin: 0.8,
      end: 0.0,
    ).animate(CurvedAnimation(parent: mainController, curve: Curves.easeOut));
  }

  @override
  void onClose() {
    mainController.dispose();
    super.onClose();
  }
}

class AppLoader extends StatelessWidget {
  final Color? color;
  const AppLoader({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    // Primary color: Electric Blue or the provided color
    final themeColor = color ?? AppColors.primary;

    return GetBuilder<_AppLoaderController>(
      init: _AppLoaderController(),
      global:
          false, // Ensures each AppLoader has its own local controller instance
      builder: (controller) {
        return LayoutBuilder(
          builder: (context, constraints) {
            // If the loader is constrained to a small box (e.g., inside a button),
            // strip background to show only the minimal animated centerpiece.
            final bool isSmall =
                constraints.maxWidth < 100 || constraints.maxHeight < 100;

            final double baseSize = isSmall
                ? math.min(constraints.maxWidth, constraints.maxHeight)
                : 100.0;
            final double iconSize = baseSize * 0.45;

            Widget loaderAnimation = AnimatedBuilder(
              animation: controller.mainController,
              builder: (context, child) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    // Pulse effect
                    if (!isSmall)
                      Transform.scale(
                        scale: controller.pulseScaleAnim.value,
                        child: Container(
                          width: baseSize * 0.7,
                          height: baseSize * 0.7,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: themeColor.withValues(
                              alpha: controller.pulseOpacityAnim.value * 0.2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: themeColor.withValues(
                                  alpha:
                                      controller.pulseOpacityAnim.value * 0.4,
                                ),
                                blurRadius: 15,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                        ),
                      ),

                    // Progress Ring
                    SizedBox(
                      width: baseSize * 0.8,
                      height: baseSize * 0.8,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                        strokeWidth: isSmall ? 2.0 : 2.5,
                        backgroundColor: themeColor.withValues(alpha: 0.1),
                      ),
                    ),

                    // Dumbbell centerpiece
                    Transform.rotate(
                      angle: controller.rotationAnim.value * 2 * math.pi,
                      child: Transform.scale(
                        scale: controller.scaleAnim.value,
                        child: Icon(
                          Icons.fitness_center,
                          color: themeColor,
                          size: iconSize,
                          shadows: [
                            if (!isSmall)
                              Shadow(
                                color: themeColor.withValues(alpha: 0.5),
                                blurRadius: 10,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );

            if (isSmall) {
              return Center(child: loaderAnimation);
            }

            return Container(
              alignment: Alignment.center,
              color: AppColors.transparent,
              child: SizedBox(
                width: baseSize,
                height: baseSize,
                child: loaderAnimation,
              ),
            );
          },
        );
      },
    );
  }
}
