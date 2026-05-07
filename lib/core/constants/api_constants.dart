class ApiConstants {
  ApiConstants._();

  // Base URIs can be configured per environment
  static const String baseUrl = 'https://api.fitflow.gym/v1';

  // Auth Endpoints
  static const String login = '/auth/login';
  static const String registerAdmin = '/auth/admin/register';
  
  // User Space
  static const String userDashboard = '/user/dashboard';
  static const String workouts = '/user/workouts';
  
  // Admin Space
  static const String adminDashboard = '/admin/dashboard';
  static const String manageUsers = '/admin/users';
  static const String manageTrainers = '/admin/trainers';

  // // Timeouts
  static const int connectTimeout = 15000; // ms
 static const int receiveTimeout = 15000; // ms
}
