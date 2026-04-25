class ExerciseModel {
  final String id;
  final String name;
  final String imageUrl;
  final int reps;
  final int duration; // in seconds
  final String muscle;

  ExerciseModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.reps = 0,
    this.duration = 0,
    required this.muscle,
  });
}
