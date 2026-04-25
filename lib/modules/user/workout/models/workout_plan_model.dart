import 'workout_day_model.dart';

class WorkoutPlan {
  final List<WorkoutDay> days;

  WorkoutPlan({required this.days});

  Map<String, dynamic> toJson() => {
        'days': days.map((e) => e.toJson()).toList(),
      };

  factory WorkoutPlan.fromJson(Map<String, dynamic> json) => WorkoutPlan(
        days: (json['days'] as List).map((e) => WorkoutDay.fromJson(e)).toList(),
      );
}
