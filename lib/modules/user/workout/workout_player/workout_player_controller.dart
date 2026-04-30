import 'dart:async';

import 'package:get/get.dart';

import '../../../../models/workout_history_model.dart';
import '../../history/history_controller.dart';
import '../../../../models/exercise_model.dart';
import '../../../../models/workout_session_model.dart';

class WorkoutPlayerController extends GetxController {
  final session = Rxn<WorkoutSessionModel>();

  final currentExerciseIndex = 0.obs;
  final currentSet = 1.obs;
  
  final isWorkoutActive = false.obs;
  final isResting = false.obs;
  
  final workoutTimeSeconds = 0.obs;
  final restTimeSeconds = 0.obs;
  final activeExerciseTimeSeconds = 0.obs;
  final totalRestTimeSeconds = 0.obs;

  final isFinished = false.obs;

  Timer? _workoutTimer;
  Timer? _restTimer;
  Timer? _activeExerciseTimer;

  @override
  void onInit() {
    super.onInit();
    _initMockSession();
  }

  void _initMockSession() {
    final exercises = [
      ExerciseModel(
        id: '1',
        name: 'Push-Up',
        imageUrl: 'https://cdn-icons-png.flaticon.com/512/2548/2548537.png', // A clean fitness icon as placeholder
        reps: 10,
        sets: 3,
        restTime: 30,
        muscle: 'Chest & Triceps',
      ),
      ExerciseModel(
        id: '2',
        name: 'Pull-Up',
        imageUrl: 'https://cdn-icons-png.flaticon.com/512/2548/2548464.png',
        reps: 8,
        sets: 3,
        restTime: 45,
        muscle: 'Back & Biceps',
      ),
      ExerciseModel(
        id: '3',
        name: 'Squats',
        imageUrl: 'https://cdn-icons-png.flaticon.com/512/2548/2548480.png',
        reps: 12,
        sets: 3,
        restTime: 60,
        muscle: 'Legs',
      ),
    ];
    session.value = WorkoutSessionModel(exercises: exercises);
  }

  void startWorkout() {
    if (isWorkoutActive.value) return;
    
    isWorkoutActive.value = true;
    _workoutTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      workoutTimeSeconds.value++;
    });
    
    _startActiveExerciseTimer();
  }

  void _startActiveExerciseTimer() {
    _activeExerciseTimer?.cancel();
    activeExerciseTimeSeconds.value = 0;
    _activeExerciseTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      activeExerciseTimeSeconds.value++;
    });
  }

  void completeSet() {
    if (session.value == null || !isWorkoutActive.value) return;

    final exercise = currentExercise;
    if (exercise == null) return;
    
    _activeExerciseTimer?.cancel();

    if (currentSet.value < exercise.sets) {
      _startRestTimer(exercise.restTime);
    } else {
      session.value!.completedExercises++;
      if (currentExerciseIndex.value < session.value!.exercises.length - 1) {
        _startRestTimer(exercise.restTime, isNextExercise: true);
      } else {
        finishWorkout();
      }
    }
  }

  void _startRestTimer(int seconds, {bool isNextExercise = false}) {
    isResting.value = true;
    restTimeSeconds.value = seconds;

    _restTimer?.cancel();
    _restTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (restTimeSeconds.value > 0) {
        restTimeSeconds.value--;
        totalRestTimeSeconds.value++;
      } else {
        timer.cancel();
        _handleRestComplete(isNextExercise);
      }
    });
  }

  void _handleRestComplete(bool isNextExercise) {
    isResting.value = false;
    if (isNextExercise) {
      currentExerciseIndex.value++;
      currentSet.value = 1;
    } else {
      currentSet.value++;
    }
    _startActiveExerciseTimer();
  }

  void skipRest() {
    _restTimer?.cancel();
    final exercise = currentExercise;
    if (exercise != null && currentSet.value == exercise.sets) {
      _handleRestComplete(true);
    } else {
      _handleRestComplete(false);
    }
  }

  void finishWorkout() {
    _workoutTimer?.cancel();
    _restTimer?.cancel();
    _activeExerciseTimer?.cancel();
    
    isWorkoutActive.value = false;

    if (session.value != null) {
      session.value!.totalTime = workoutTimeSeconds.value;

      final historyCtrl = Get.put(HistoryController());
      historyCtrl.saveWorkout(
        WorkoutHistoryModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          name: 'Daily Routine',
          date: DateTime.now(),
          duration: workoutTimeSeconds.value,
          calories: _calculateCalories(),
          exerciseCount: session.value!.completedExercises,
        ),
      );
    }
    isFinished.value = true;
  }
  
  int _calculateCalories() {
    // Simple mock calculation: ~8 calories per minute of active workout
    final totalMinutes = workoutTimeSeconds.value / 60;
    return (totalMinutes * 8).round();
  }

  double get progress {
    if (session.value == null || session.value!.exercises.isEmpty) return 0.0;
    
    int totalSets = 0;
    int completedSets = 0;
    
    for (int i = 0; i < session.value!.exercises.length; i++) {
        final ex = session.value!.exercises[i];
        totalSets += ex.sets;
        if (i < currentExerciseIndex.value) {
            completedSets += ex.sets;
        } else if (i == currentExerciseIndex.value) {
            // For current exercise, if resting after a set, that set is complete.
            // If active, it's not complete yet.
            int setsDone = isResting.value ? currentSet.value : currentSet.value - 1;
            completedSets += setsDone;
        }
    }
    
    if (totalSets == 0) return 0.0;
    return completedSets / totalSets;
  }

  ExerciseModel? get currentExercise {
    if (session.value == null || session.value!.exercises.isEmpty) return null;
    return session.value!.exercises[currentExerciseIndex.value];
  }

  String _formatTime(int totalSeconds) {
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  String get formattedActiveExerciseTime => _formatTime(activeExerciseTimeSeconds.value);
  String get formattedRestTime => _formatTime(restTimeSeconds.value);
  String get formattedWorkoutTime => _formatTime(workoutTimeSeconds.value);
  String get formattedTotalRestTime => _formatTime(totalRestTimeSeconds.value);

  @override
  void onClose() {
    _workoutTimer?.cancel();
    _restTimer?.cancel();
    _activeExerciseTimer?.cancel();
    super.onClose();
  }
}
