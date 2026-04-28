class WorkoutHistoryModel {
  final String id;
  final String name;
  final DateTime date;
  final int duration;
  final int calories;
  final int exerciseCount;

  WorkoutHistoryModel({
    required this.id,
    required this.name,
    required this.date,
    required this.duration,
    required this.calories,
    required this.exerciseCount,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'date': date.toIso8601String(),
        'duration': duration,
        'calories': calories,
        'exerciseCount': exerciseCount,
      };

  factory WorkoutHistoryModel.fromJson(Map<String, dynamic> json) => WorkoutHistoryModel(
        id: json['id'],
        name: json['name'],
        date: DateTime.parse(json['date']),
        duration: json['duration'],
        calories: json['calories'],
        exerciseCount: json['exerciseCount'],
      );
}
