class GymModel {
  final String id;
  final String name;
  final String role;
  final String status;

  GymModel({
    required this.id,
    required this.name,
    required this.role,
    this.status = 'Offline',
  });
}


// dummy data for gym model

final GymModel dummyGym = GymModel(
  id: '1',
  name: 'Gym Owner',
  role: 'Gym Owner',
  status: 'Offline',
);
