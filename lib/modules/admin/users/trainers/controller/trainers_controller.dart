import 'package:get/get.dart';
import '../../../../../core/theme/app_colors.dart';

class TrainerModel {
  final String id;
  final String name;
  final String email;
  final String specialization;
  final double rating;
  final String status;
  
  TrainerModel({
    required this.id,
    required this.name,
    required this.email,
    required this.specialization,
    required this.rating,
    required this.status,
  });

  TrainerModel copyWith({
    String? name,
    String? email,
    String? specialization,
    double? rating,
    String? status,
  }) {
    return TrainerModel(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      specialization: specialization ?? this.specialization,
      rating: rating ?? this.rating,
      status: status ?? this.status,
    );
  }
}

class TrainersController extends GetxController {
  final isLoading = true.obs;
  final trainers = <TrainerModel>[].obs;
  
  // Search and Filter state
  final searchQuery = ''.obs;
  final statusFilter = 'All'.obs;
  final specializationFilter = 'All'.obs;

  // Filtered list
  List<TrainerModel> get filteredTrainers {
    return trainers.where((trainer) {
      final matchesSearch = trainer.name.toLowerCase().contains(searchQuery.value.toLowerCase()) || 
                          trainer.email.toLowerCase().contains(searchQuery.value.toLowerCase());
      final matchesStatus = statusFilter.value == 'All' || trainer.status == statusFilter.value;
      final matchesSpecialization = specializationFilter.value == 'All' || trainer.specialization == specializationFilter.value;
      
      return matchesSearch && matchesStatus && matchesSpecialization;
    }).toList();
  }

  int get totalTrainersCount => trainers.length;
  int get filteredTrainersCount => filteredTrainers.length;
  
  @override
  void onInit() {
    super.onInit();
    _loadTrainers();
  }

  void _loadTrainers() async {
    isLoading.value = true;
    try {
      // Mock network fetch
      await Future.delayed(const Duration(milliseconds: 800));
      
      trainers.value = [
        TrainerModel(id: '1', name: 'Chris Hemsworth', email: 'chris@example.com', specialization: 'Strength', rating: 4.8, status: 'Active'),
        TrainerModel(id: '2', name: 'Jillian Michaels', email: 'jillian@example.com', specialization: 'Cardio', rating: 4.9, status: 'Active'),
        TrainerModel(id: '3', name: 'Adriene Mishler', email: 'adriene@example.com', specialization: 'Yoga', rating: 4.9, status: 'Active'),
        TrainerModel(id: '4', name: 'Mat Fraser', email: 'mat@example.com', specialization: 'CrossFit', rating: 4.7, status: 'Inactive'),
        TrainerModel(id: '5', name: 'Joe Wicks', email: 'joe@example.com', specialization: 'General Fitness', rating: 4.6, status: 'Active'),
      ];
    } finally {
      isLoading.value = false;
    }
  }

  void addTrainer(String name, String email, String specialization) {
    isLoading.value = true;
    Future.delayed(const Duration(milliseconds: 500), () {
      final newTrainer = TrainerModel(
        id: (trainers.length + 1).toString(),
        name: name,
        email: email,
        specialization: specialization,
        rating: 5.0, // Default for new
        status: 'Active',
      );
      trainers.add(newTrainer);
      isLoading.value = false;
      
      Get.back(); // close modal
      Get.snackbar(
        'Success',
        'Trainer added successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.success.withValues(alpha: 0.1),
        colorText: AppColors.success,
      );
    });
  }

  void updateTrainer(TrainerModel updatedTrainer) {
    final index = trainers.indexWhere((t) => t.id == updatedTrainer.id);
    if (index != -1) {
      trainers[index] = updatedTrainer;
      Get.back(); // close modal
      Get.snackbar(
        'Success',
        'Trainer updated successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.success.withValues(alpha: 0.1),
        colorText: AppColors.success,
      );
    }
  }

  void deleteTrainer(String id) {
    trainers.removeWhere((t) => t.id == id);
    Get.snackbar(
      'Success',
      'Trainer removed successfully.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
