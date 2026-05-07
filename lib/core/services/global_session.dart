import 'package:fitflow/core/constants/app_shared_pref_key.dart';
import 'package:fitflow/core/constants/ennum.dart';
import 'package:fitflow/models/gym_model.dart';
import 'package:fitflow/models/trainer_model.dart';
import 'package:fitflow/models/user_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class GlobalSessionController extends GetxController {
  
  final roleKey = AppSharedPrefKey.loginedRole;
  final prefs =  SharedPreferences.getInstance();
  

  /// ================================
  /// CURRENT ROLE
  /// ================================

  final Rx<UserRole?> currentRole = Rx<UserRole?>(null);

  /// ================================
  /// LOGIN STATUS
  /// ================================

  final RxBool isLoggedIn = false.obs;

  /// ================================
  /// TOKEN
  /// ================================

  // final RxString token = ''.obs;

  /// ================================
  /// USER MODELS
  /// ================================

  final Rxn<UserModel> currentUser = Rxn<UserModel>();

  final Rxn<GymModel> currentGym = Rxn<GymModel>();

  final Rxn<TrainerModel> currentTrainer = Rxn<TrainerModel>();

  /// ================================
  /// USER LOGIN
  /// ================================

  void setUserSession({
    required UserModel user,
    // required String accessToken,
  }) {

    currentRole.value = UserRole.user;

    currentUser.value = user;

    // token.value = accessToken;

    isLoggedIn.value = true;
  }

  /// ================================
  /// GYM LOGIN
  /// ================================

  void setGymSession({
    required GymModel gym,
    // required String accessToken,
  }) {

    currentRole.value = UserRole.gymOwner;

    currentGym.value = gym;

    // token.value = accessToken;

    isLoggedIn.value = true;
  }

  /// ================================
  /// TRAINER LOGIN
  /// ================================

  void setTrainerSession({
    required TrainerModel trainer,
    // required String accessToken,
  }) {

    currentRole.value = UserRole.trainer;

    currentTrainer.value = trainer;

    // token.value = accessToken;

    isLoggedIn.value = true;
  }

  /// ================================
  /// ROLE CHECKERS
  /// ================================

  bool get isUser => currentRole.value == UserRole.user;

  bool get isGym => currentRole.value == UserRole.gymOwner;

  bool get isTrainer => currentRole.value == UserRole.trainer;

  /// ================================
  /// LOGOUT
  /// ================================

  Future<void> clearSession() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(roleKey);
    await prefs.clear();

    currentRole.value = null;

    currentUser.value = null;

    currentGym.value = null;

    currentTrainer.value = null;

    // token.value = '';

    isLoggedIn.value = false;
  }
}



