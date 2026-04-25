import 'dart:async';
import 'package:get/get.dart';
import 'models/exercise_model.dart';
import 'models/workout_session_model.dart';
import '../history/history_controller.dart';
import '../history/models/workout_history_model.dart';

class WorkoutPlayerController extends GetxController {
  final session = Rxn<WorkoutSessionModel>();
  
  final currentExerciseIndex = 0.obs;
  final isResting = false.obs;
  final workoutTimeSeconds = 0.obs;
  final restTimeSeconds = 0.obs;
  final isFinished = false.obs;

  Timer? _workoutTimer;
  Timer? _restTimer;

  @override
  void onInit() {
    super.onInit();
    _initMockSession();
  }

  void _initMockSession() {
    final exercises = [
      ExerciseModel(id: '1', name: 'Jumping Jacks', imageUrl: '', duration: 30, muscle: 'Full Body'),
      ExerciseModel(id: '2', name: 'Push Ups', imageUrl: '', reps: 15, muscle: 'Chest & Triceps'),
      ExerciseModel(id: '3', name: 'Squats', imageUrl: '', reps: 20, muscle: 'Legs'),
      ExerciseModel(id: '4', name: 'Plank', imageUrl: '', duration: 60, muscle: 'Core'),
    ];
    session.value = WorkoutSessionModel(exercises: exercises);
    startWorkout();
  }

  void startWorkout() {
    _workoutTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      workoutTimeSeconds.value++;
    });
  }

  void completeExercise() {
    if (session.value == null) return;
    
    session.value!.completedExercises++;
    
    if (currentExerciseIndex.value < session.value!.exercises.length - 1) {
      startRestTimer(30); // 30 seconds rest
    } else {
      finishWorkout();
    }
  }

  void startRestTimer(int seconds) {
    isResting.value = true;
    restTimeSeconds.value = seconds;

    _restTimer?.cancel();
    _restTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (restTimeSeconds.value > 0) {
        restTimeSeconds.value--;
      } else {
        timer.cancel();
        isResting.value = false;
        nextExercise();
      }
    });
  }

  void skipRest() {
    _restTimer?.cancel();
    isResting.value = false;
    nextExercise();
  }

  void nextExercise() {
    if (session.value == null) return;
    if (currentExerciseIndex.value < session.value!.exercises.length - 1) {
      currentExerciseIndex.value++;
    } else {
      finishWorkout();
    }
  }

  void previousExercise() {
    if (currentExerciseIndex.value > 0) {
      currentExerciseIndex.value--;
    }
  }

  void skipExercise() {
    nextExercise();
  }

  void finishWorkout() {
    _workoutTimer?.cancel();
    _restTimer?.cancel();
    
    if (session.value != null) {
      session.value!.totalTime = workoutTimeSeconds.value;

      final historyCtrl = Get.put(HistoryController());
      historyCtrl.saveWorkout(
        WorkoutHistoryModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          name: 'Daily Routine',
          date: DateTime.now(),
          duration: workoutTimeSeconds.value,
          calories: 350, 
          exerciseCount: session.value!.completedExercises,
        ),
      );
    }
    isFinished.value = true;
  }

  double get progress {
    if (session.value == null || session.value!.exercises.isEmpty) return 0.0;
    // Calculate progress smoothly
    return (currentExerciseIndex.value) / session.value!.exercises.length;
  }

  ExerciseModel? get currentExercise {
    if (session.value == null) return null;
    return session.value!.exercises[currentExerciseIndex.value];
  }

  String get formattedWorkoutTime {
    int minutes = workoutTimeSeconds.value ~/ 60;
    int seconds = workoutTimeSeconds.value % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void onClose() {
    _workoutTimer?.cancel();
    _restTimer?.cancel();
    super.onClose();
  }
}
