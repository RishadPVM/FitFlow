class WorkoutPlanModel {
  final String title;
  final WeekDay day;
  final List<String> exercises;
  final int duration;
  final int sets;


  WorkoutPlanModel({
    required this.title,
    required this.day,
    required this.exercises,
    required this.duration,
    required this.sets,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'day': day.name,
        'exercises': exercises,
        'duration': duration,
        'sets': sets,

      };

  factory WorkoutPlanModel.fromJson(Map<String, dynamic> json) => WorkoutPlanModel(
        title: json['title'],
        day: json['day'],
        exercises: json['exercises'],
        duration: json['duration'],
        sets: json['sets'],
      );
}

enum WeekDay {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}

// extension WorkoutDayExtension on WeekDay {
//   String get name {
//     switch (this) {
//       case WeekDay.monday:
//         return 'Monday';
//       case WeekDay.tuesday:
//         return 'Tuesday';
//       case WeekDay.wednesday:
//         return 'Wednesday';
//       case WeekDay.thursday:
//         return 'Thursday';
//       case WeekDay.friday:
//         return 'Friday';
//       case WeekDay.saturday:
//         return 'Saturday';
//       case WeekDay.sunday:
//         return 'Sunday';
//     }
//   }
// }
