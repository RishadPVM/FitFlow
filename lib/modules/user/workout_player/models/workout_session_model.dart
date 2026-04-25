import 'exercise_model.dart';

class WorkoutSessionModel {
  final List<ExerciseModel> exercises;
  int currentIndex;
  int completedExercises;
  int totalTime; // in seconds

  WorkoutSessionModel({
    required this.exercises,
    this.currentIndex = 0,
    this.completedExercises = 0,
    this.totalTime = 0,
  });
}
