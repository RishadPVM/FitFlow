import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import 'role_selection_controller.dart';
import 'widgets/role_carousel_card.dart';

class GridTexturePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.04)
      ..style = PaintingStyle.fill;
    
    const spacing = 24.0;
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 1.5, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class RoleSelectionPage extends GetView<RoleSelectionController> {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background Texture (Dotted Grid)
          Positioned.fill(
            child: CustomPaint(
              painter: GridTexturePainter(),
            ),
          ),
          
          // Dynamic Radial Gradient Glow
          Obx(() {
            // Glow color changes slightly based on selected role
            final isUser = controller.highlightedRole.value == 'user';
            final glowColor = isUser 
                ? AppColors.primary.withOpacity(0.15)
                : AppColors.primaryBlue.withOpacity(0.1);
                
            return AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0.0, 0.2),
                  radius: 1.2,
                  colors: [
                    glowColor,
                    AppColors.background.withOpacity(0.8),
                    AppColors.background,
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            );
          }),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 48),
                
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "FitFlow",
                        style: AppTextStyles.h1.copyWith(
                          color: AppColors.primary,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Choose your path.",
                        style: AppTextStyles.h2.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Swipe to explore roles",
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const Spacer(flex: 1),
                
                // Carousel
                SizedBox(
                  height: 480, // Fixed height for carousel cards
                  child: PageView.builder(
                    controller: controller.pageController,
                    onPageChanged: controller.onPageChanged,
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.roles.length,
                    itemBuilder: (context, index) {
                      final role = controller.roles[index];
                      
                      return Obx(() {
                        final isSelected = controller.currentIndex.value == index;
                        return RoleCarouselCard(
                          role: role,
                          isSelected: isSelected,
                          onSelect: () => controller.selectRole(role.id),
                        );
                      });
                    },
                  ),
                ),
                
                const Spacer(flex: 2),
                
                // Bottom Page Indicators
                Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(controller.roles.length, (index) {
                    final isSelected = controller.currentIndex.value == index;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 6,
                      width: isSelected ? 24 : 6,
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : AppColors.divider,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    );
                  }),
                )),
                
                const SizedBox(height: 48),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
