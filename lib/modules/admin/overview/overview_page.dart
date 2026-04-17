import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../common/widgets/app_loader.dart';
import '../../../core/constants/app_strings.dart';
import 'controller/overview_controller.dart';
import 'widget/premium_metric_card.dart';
import 'widget/revenue_chart.dart';

class OverviewPage extends GetView<OverviewController> {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Obx(() {
        if (controller.isLoading.value && controller.totalUsers.value == 0) {
          return const Center(child: AppLoader());
        }

        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back, Admin',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Dashboard Overview',
                      style: AppTextStyles.h1.copyWith(
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(24.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  Row(
                    children: [
                      Expanded(
                        child: buildPremiumMetricCard(
                          title: AppStrings.activeSession,
                          value: controller.activeSessions.value.toString(),
                          icon: Icons.bolt_rounded,
                          accentColor: AppColors.primary,
                          gradientColors: [
                            AppColors.primary.withValues(alpha: 0.15),
                            AppColors.surfaceLight,
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: buildPremiumMetricCard(
                          title: AppStrings.totalUsers,
                          value: controller.totalUsers.value.toString(),
                          icon: Icons.people_alt_rounded,
                          accentColor: AppColors.primaryBlue,
                          gradientColors: [
                            AppColors.primaryBlue.withValues(alpha: 0.15),
                            AppColors.surfaceLight,
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  buildPremiumMetricCard(
                    title: 'Total ${AppStrings.revenue}',
                    value: controller.revenue.value,
                    icon: Icons.attach_money_rounded,
                    accentColor: AppColors.secondaryGreen,
                    gradientColors: [
                      AppColors.secondaryGreen.withValues(alpha: 0.1),
                      AppColors.surfaceLight,
                    ],
                    isWide: true,
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Revenue Trends',
                        style: AppTextStyles.h3,
                      ),
                      Icon(Icons.more_horiz, color: AppColors.textSecondary),
                    ],
                  ),
                  const SizedBox(height: 16),
                  buildChartPlaceholder(),
                  const SizedBox(height: 120), // Bottom padding for FAB/Navbar
                ]),
              ),
            ),
          ],
        );
      }),
    );
  }
}
