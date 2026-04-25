import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../history_controller.dart';

class CalendarWidget extends GetView<HistoryController> {
  const CalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.divider.withValues(alpha:0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.2),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 16),
          _buildDaysOfWeek(),
          const SizedBox(height: 8),
          _buildGrid(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Obx(() {
      final month = controller.selectedMonth.value;
      final monthNames = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(
              Icons.chevron_left_rounded,
              color: AppColors.textPrimary,
            ),
            onPressed: () {
              controller.onMonthChanged(DateTime(month.year, month.month - 1));
            },
          ),
          Text(
            '${monthNames[month.month - 1]} ${month.year}',
            style: AppTextStyles.h2.copyWith(color: AppColors.textPrimary),
          ),
          IconButton(
            icon: const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textPrimary,
            ),
            onPressed: () {
              controller.onMonthChanged(DateTime(month.year, month.month + 1));
            },
          ),
        ],
      );
    });
  }

  Widget _buildDaysOfWeek() {
    final days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: days
          .map(
            (d) => Text(
              d,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildGrid() {
    return Obx(() {
      final month = controller.selectedMonth.value;
      final selectedDate = controller.selectedDate.value;
      final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
      final firstDayWeekday = DateTime(
        month.year,
        month.month,
        1,
      ).weekday; // 1 = Mon, 7 = Sun

      final emptyBoxes = firstDayWeekday - 1;
      final totalBoxes = emptyBoxes + daysInMonth;

      final groupedWorkouts = controller.groupByDate();

      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemCount: totalBoxes,
        itemBuilder: (context, index) {
          if (index < emptyBoxes) return const SizedBox();

          final day = index - emptyBoxes + 1;
          final currentDate = DateTime(month.year, month.month, day);
          final isSelected =
              currentDate.year == selectedDate.year &&
              currentDate.month == selectedDate.month &&
              currentDate.day == selectedDate.day;
          final hasWorkout = groupedWorkouts.containsKey(currentDate);

          return GestureDetector(
            onTap: () => controller.onDateSelected(currentDate),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.transparent,
                shape: BoxShape.circle,
                border: hasWorkout && !isSelected
                    ? Border.all(
                        color: AppColors.primary.withValues(alpha:0.5),
                        width: 2,
                      )
                    : null,
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha:0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$day',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: isSelected
                          ? AppColors.background
                          : AppColors.textPrimary,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  if (hasWorkout)
                    Container(
                      margin: const EdgeInsets.only(top: 2),
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.background
                            : AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
