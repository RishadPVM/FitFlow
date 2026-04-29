import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class TimerSection extends StatelessWidget {
  final bool isResting;
  final String activeTime;
  final String restTime;

  const TimerSection({
    super.key,
    required this.isResting,
    required this.activeTime,
    required this.restTime,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),
      switchInCurve: Curves.easeOutBack,
      switchOutCurve: Curves.easeIn,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.8, end: 1.0).animate(animation),
            child: child,
          ),
        );
      },
      child: isResting
          ? _buildGlowTimer(
              key: const ValueKey('rest'),
              title: 'REST MODE',
              time: restTime,
              color: AppColors.secondaryGreen,
              icon: Icons.self_improvement_rounded,
            )
          : _buildGlowTimer(
              key: const ValueKey('active'),
              title: 'ACTIVE TIME',
              time: activeTime,
              color: AppColors.primaryBlue, // Changed to electric blue for active
              icon: Icons.timer_outlined,
            ),
    );
  }

  Widget _buildGlowTimer({
    required Key key,
    required String title,
    required String time,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      key: key,
      width: double.infinity,
      height: 120, // fixed height to prevent layout jumps
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Inner glow
          Positioned(
            child: Container(
              width: 150,
              height: 50,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: color.withValues(alpha: 0.4), blurRadius: 40)
                ],
              ),
            ),
          ),
          // Content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, color: color, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: color,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                time,
                style: AppTextStyles.h1.copyWith(
                  color: AppColors.textPrimary,
                  fontSize: 56,
                  height: 1.0,
                  fontFeatures: const [FontFeature.tabularFigures()],
                  shadows: [
                    Shadow(color: color.withValues(alpha: 0.5), blurRadius: 10),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
