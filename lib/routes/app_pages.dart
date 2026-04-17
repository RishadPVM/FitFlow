import 'package:fitflow/modules/admin/finance/finance_controller.dart';
import 'package:get/get.dart';
import 'app_routes.dart';

// Modules
import '../modules/role_selection/role_selection_page.dart';
import '../modules/role_selection/role_selection_controller.dart';
import '../modules/auth/login/login_page.dart';
import '../modules/auth/login/login_controller.dart';
import '../modules/user/dashboard/user_dashboard_page.dart';
import '../modules/user/dashboard/user_dashboard_controller.dart';
import '../modules/admin/admin_bottom_navigation/admin_bottom_nav_page.dart';
import '../modules/admin/admin_bottom_navigation/controller/admin_bottom_nav_controller.dart';
import '../modules/admin/overview/controller/overview_controller.dart';
import '../modules/admin/users/members/controller/admin_members_controller.dart';
import '../modules/admin/users/trainers/controller/trainers_controller.dart';
import '../modules/admin/attendance/controller/attendance_controller.dart';
import '../modules/chat/chat_controller.dart';
import '../modules/admin/profile/controller/admin_profile_controller.dart';
import '../modules/admin/meet/meet_controller.dart';

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
      name: AppRoutes.userDashboard,
      page: () => const UserDashboardPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<UserDashboardController>(() => UserDashboardController());
        Get.lazyPut<ChatController>(() => ChatController());
        Get.lazyPut<AdminProfileController>(() => AdminProfileController());
        Get.lazyPut<FinanceController>(() => FinanceController());
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
        Get.lazyPut<TrainersController>(() => TrainersController());
        Get.lazyPut<AttendanceController>(() => AttendanceController());
        Get.lazyPut<FinanceController>(() => FinanceController());
        Get.lazyPut<ChatController>(() => ChatController());
        Get.lazyPut<MeetController>(() => MeetController());
        Get.lazyPut<AdminProfileController>(() => AdminProfileController());
      }),
    ),
  ];
}
