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