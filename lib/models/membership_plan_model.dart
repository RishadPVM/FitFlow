class MembershipPlanModel {
  String id;
  String name;
  double price;
  int durationInMonths;
  List<String> features;
  int activeMembers;
  bool isActive;
  bool isPopular;

  MembershipPlanModel({
    required this.id,
    required this.name,
    required this.price,
    required this.durationInMonths,
    required this.features,
    this.activeMembers = 0,
    this.isActive = true,
    this.isPopular = false,
  });

  double get revenue => price * activeMembers;

  MembershipPlanModel copyWith({
    String? id,
    String? name,
    double? price,
    int? durationInMonths,
    List<String>? features,
    int? activeMembers,
    bool? isActive,
    bool? isPopular,
  }) {
    return MembershipPlanModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      durationInMonths: durationInMonths ?? this.durationInMonths,
      features: features ?? this.features,
      activeMembers: activeMembers ?? this.activeMembers,
      isActive: isActive ?? this.isActive,
      isPopular: isPopular ?? this.isPopular,
    );
  }
}
