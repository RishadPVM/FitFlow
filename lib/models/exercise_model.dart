class ExerciseModel {
  final String? id;
  final String name;
  final String imageUrl;
  final int reps;
  final int sets;
  final int duration; // in seconds
  final int restTime; // in seconds
  final String muscle;

  ExerciseModel({
    this.id,
    required this.name,
    required this.imageUrl,
    this.reps = 0,
    this.sets = 1,
    this.duration = 0,
    this.restTime = 30,
    required this.muscle,
  });

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image_url'],
      reps: json['reps'],
      sets: json['sets'],
      duration: json['duration'],
      restTime: json['rest_time'],
      muscle: json['muscle'],
    );
  }
}
