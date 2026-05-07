
class UserModel {
  final String id;
  final String name;
  final String email;
  final String plan;
  final String status;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.plan,
    required this.status,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? plan,
    String? status,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      plan: plan ?? this.plan,
      status: status ?? this.status,
    );
  }
}


// add dummy data


final UserModel dummyUser = UserModel(
  id: '1',
  name: 'John Doe',
  email: 'JohnDoe@gmail.com',
  plan: 'Premium',
  status: 'Active',
);

