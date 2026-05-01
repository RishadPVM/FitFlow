import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../role_selection_controller.dart';

class RoleCarouselCard extends StatelessWidget {
  final RoleItem role;
  final bool isSelected;
  final VoidCallback onSelect;

  const RoleCarouselCard({
    super.key,
    required this.role,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
      margin: EdgeInsets.only(
        top: isSelected ? 0 : 32,
        bottom: isSelected ? 0 : 32,
        left: 8,
        right: 8,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface.withOpacity(isSelected ? 0.9 : 0.5),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.divider.withOpacity(0.5),
          width: isSelected ? 2 : 1,
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.2),
                  blurRadius: 30,
                  spreadRadius: -5,
                  offset: const Offset(0, 10),
                )
              ]
            : [],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ColorFilter.mode(
            Colors.black.withOpacity(0.01),
            BlendMode.srcOver,
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                
                // Icon Section
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary.withOpacity(0.1)
                        : AppColors.surfaceLight,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    role.icon,
                    size: isSelected ? 64 : 48,
                    color: isSelected ? AppColors.primary : AppColors.textSecondary,
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Title
                Text(
                  role.title,
                  style: AppTextStyles.h1.copyWith(
                    fontSize: isSelected ? 28 : 20,
                    color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 16),
                
                // Description (Animated Opacity and Height)
                AnimatedOpacity(
                  opacity: isSelected ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: isSelected ? null : 0,
                    child: Text(
                      role.description,
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                
                const Spacer(),
                
                // CTA Button
                AnimatedOpacity(
                  opacity: isSelected ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: isSelected ? 56 : 0,
                    width: double.infinity,
                    child: isSelected
                        ? ElevatedButton(
                            onPressed: onSelect,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: AppColors.background,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              role.ctaText,
                              style: AppTextStyles.buttonText,
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
