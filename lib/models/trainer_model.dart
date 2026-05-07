
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



// dummy data for trainer model

final TrainerModel dummyTrainer = TrainerModel(
  id: '1',
  name: 'Trainer Doe',
  email: 'Trainer@gmail.com',
  specialization: 'Fitness',
  rating: 4.5,
  status: 'Active',
);