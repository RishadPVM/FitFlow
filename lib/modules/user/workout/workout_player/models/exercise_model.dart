class ExerciseModel {
  final String id;
  final String name;
  final String imageUrl;
  final int reps;
  final int sets;
  final int duration; // in seconds
  final int restTime; // in seconds
  final String muscle;

  ExerciseModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.reps = 0,
    this.sets = 1,
    this.duration = 0,
    this.restTime = 30,
    required this.muscle,
  });
}
