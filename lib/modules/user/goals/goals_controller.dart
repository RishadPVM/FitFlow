import 'package:get/get.dart';

class GoalsController extends GetxController {
  final RxString selectedGoal = 'Weight Loss'.obs;
  
  void setGoal(String goal) {
    selectedGoal.value = goal;
  }
}
