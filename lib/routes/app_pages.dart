import 'package:fitflow/modules/admin/profile/finance/controller/finance_controller.dart';
import 'package:get/get.dart';

import '../modules/admin/admin_bottom_navigation/admin_bottom_nav_page.dart';
import '../modules/admin/admin_bottom_navigation/controller/admin_bottom_nav_controller.dart';
import '../modules/admin/attendance/controller/attendance_controller.dart';
import '../modules/admin/meet/meet_controller.dart';
import '../modules/admin/overview/controller/overview_controller.dart';
import '../modules/admin/profile/controller/admin_profile_controller.dart';
import '../modules/admin/users/members/controller/admin_members_controller.dart';
import '../modules/admin/users/trainers/controller/trainers_controller.dart';
import '../modules/auth/login/login_controller.dart';
import '../modules/auth/login/login_page.dart';
import '../modules/user/user_bottom_navigation/user_bottom_nav_page.dart';
import '../modules/user/user_bottom_navigation/user_bottom_nav_controller.dart';
import '../modules/user/home/user_home_controller.dart';
import '../modules/user/meet/user_meet_controller.dart';
import '../modules/user/goals/goals_controller.dart';
import '../modules/user/profile/profile_controller.dart';
import '../modules/user/meet/user_chat_screen.dart';
import '../modules/role_selection/role_selection_controller.dart';
  // Modules
import '../modules/role_selection/role_selection_page.dart';
import '../modules/user/qr_scanner/qr_scanner_page.dart';
import '../modules/user/qr_scanner/qr_scanner_controller.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = AppRoutes.roleSelection;

  static final routes = [
    GetPage(
      name: AppRoutes.roleSelection,
      page: () => const RoleSelectionPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<RoleSelectionController>(() => RoleSelectionController());
      }),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<LoginController>(() => LoginController());
      }),
    ),
    GetPage(
      name: AppRoutes.userBottomNav,
      page: () => const UserBottomNavPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<UserBottomNavController>(() => UserBottomNavController());
        Get.lazyPut<UserHomeController>(() => UserHomeController());
        Get.lazyPut<UserMeetController>(() => UserMeetController());
        Get.lazyPut<GoalsController>(() => GoalsController());
        Get.lazyPut<UserProfileController>(() => UserProfileController());
      }),
    ),
    GetPage(
      name: AppRoutes.chatScreen,
      page: () => const UserChatScreen(),
    ),
    GetPage(
      name: AppRoutes.qrScanner,
      page: () => const QrScannerPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<QrScannerController>(() => QrScannerController());
      }),
    ),
    GetPage(
      name: AppRoutes.adminDashboard,
      page: () => const AdminBottomNavigation(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AdminBottomNavController>(() => AdminBottomNavController());
        // Sub-modules
        Get.lazyPut<OverviewController>(() => OverviewController());
        Get.lazyPut<AdminMembersController>(() => AdminMembersController());
        Get.lazyPut<AdminTrainerController>(() => AdminTrainerController());
        Get.lazyPut<AttendanceController>(() => AttendanceController());
        Get.lazyPut<FinanceController>(() => FinanceController());
        // Get.lazyPut<UserChatController>(() => UserChatController());
        Get.lazyPut<MeetController>(() => MeetController());
        Get.lazyPut<AdminProfileController>(() => AdminProfileController());
      }),
    ),
  ];
}
