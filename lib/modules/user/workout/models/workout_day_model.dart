class WorkoutDay {
  final String title;
  final int exercisesCount;
  final int duration; // in minutes
  final int calories;
  final String type; // e.g., "Full Body", "Upper Body", "Cardio"

  WorkoutDay({
    required this.title,
    required this.exercisesCount,
    required this.duration,
    required this.calories,
    required this.type,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'exercisesCount': exercisesCount,
        'duration': duration,
        'calories': calories,
        'type': type,
      };

  factory WorkoutDay.fromJson(Map<String, dynamic> json) => WorkoutDay(
        title: json['title'],
        exercisesCount: json['exercisesCount'],
        duration: json['duration'],
        calories: json['calories'],
        type: json['type'],
      );
}
