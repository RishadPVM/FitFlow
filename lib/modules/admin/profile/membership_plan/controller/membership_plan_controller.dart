import 'package:get/get.dart';

import '../../../../../models/membership_plan_model.dart';

class MembershipPlanController extends GetxController {
  final RxList<MembershipPlanModel> plans = <MembershipPlanModel>[].obs;


  final RxString searchQuery = ''.obs;
  final RxString selectedDurationFilter = 'All'.obs;

  @override
  void onInit() {
    super.onInit();
    _loadDummyData();
  }

  void _loadDummyData() {
    plans.assignAll([
      MembershipPlanModel(
        id: '1',
        name: 'Basic Plan',
        price: 999,
        durationInMonths: 1,
        features: ['Gym Access', 'Locker Facility', 'Free WiFi'],
        activeMembers: 120,
        isActive: true,
      ),
      MembershipPlanModel(
        id: '2',
        name: 'Pro Plan',
        price: 2499,
        durationInMonths: 3,
        features: ['All Basic Features', 'Personal Diet Plan', 'Group Classes'],
        activeMembers: 250,
        isActive: true,
        isPopular: true,
      ),
      MembershipPlanModel(
        id: '3',
        name: 'Premium',
        price: 7999,
        durationInMonths: 12,
        features: [
          'All Pro Features',
          'Personal Trainer (2 sessions/mo)',
          'Spa Access',
        ],
        activeMembers: 85,
        isActive: true,
      ),
      MembershipPlanModel(
        id: '4',
        name: 'Weekend Warrior',
        price: 499,
        durationInMonths: 1,
        features: ['Sat/Sun Gym Access', 'Group Classes'],
        activeMembers: 0,
        isActive: false,
      ),
    ]);
  }

  List<MembershipPlanModel> get filteredPlans {
    return plans.where((plan) {
      final matchesSearch = plan.name.toLowerCase().contains(
        searchQuery.value.toLowerCase(),
      );
      final matchesDuration =
          selectedDurationFilter.value == 'All' ||
          (selectedDurationFilter.value == '1 Month' &&
              plan.durationInMonths == 1) ||
          (selectedDurationFilter.value == '3 Months' &&
              plan.durationInMonths == 3) ||
          (selectedDurationFilter.value == 'Yearly' &&
              plan.durationInMonths == 12);

      return matchesSearch && matchesDuration;
    }).toList();
  }

  void addPlan(MembershipPlanModel plan) {
    plans.add(plan);
  }

  void updatePlan(MembershipPlanModel updatedPlan) {
    final index = plans.indexWhere((p) => p.id == updatedPlan.id);
    if (index != -1) {
      plans[index] = updatedPlan;
    }
  }

  void deletePlan(String id) {
    plans.removeWhere((p) => p.id == id);
  }

  void togglePlanStatus(String id) {
    final index = plans.indexWhere((p) => p.id == id);
    if (index != -1) {
      final current = plans[index];
      plans[index] = current.copyWith(isActive: !current.isActive);
    }
  }
}
