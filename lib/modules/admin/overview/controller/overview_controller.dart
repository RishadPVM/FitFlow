import 'package:get/get.dart';

// Dummy model for chart data
class ChartData {
  final String label;
  final double value;

  ChartData(this.label, this.value);
}

// Dummy model for activity
class ActivityLog {
  final String userName;
  final String action;
  final String time;
  final bool isEntry;

  ActivityLog(this.userName, this.action, this.time, this.isEntry);
}

class OverviewController extends GetxController {
  // final StorageService? _storage = Get.isRegistered<StorageService>() ? Get.find<StorageService>() : null;

  // --- Observables (Reactive Variables) ---
  final RxBool isLoading = true.obs;
  final RxBool isRefreshing = false.obs;
  final RxString error = ''.obs;

  final RxInt totalUsers = 0.obs;
  final RxInt activeUsers = 0.obs;
  final RxInt workingUsers = 0.obs; // Currently live in gym
  final RxDouble pendingAmount = 0.0.obs;
  final RxInt pendingUsersCount = 0.obs;

  final RxList<ChartData> userGrowthData = <ChartData>[].obs;
  final RxList<ActivityLog> liveActivityList = <ActivityLog>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadInitialData();
  }

  /// Entry point for data fetching
  Future<void> _loadInitialData() async {
    isLoading.value = true;
    _readFromCache();
    await _fetchFromAPI();
    isLoading.value = false;
  }

  /// Pull-to-refresh
  Future<void> refreshData() async {
    isRefreshing.value = true;
    await _fetchFromAPI();
    isRefreshing.value = false;
  }

  /// 1. Load Cached Data First (Hive)
  void _readFromCache() {
    // if (_storage == null) return;
    // try {
    //   totalUsers.value = _storage!.read<int>('overview_totalUsers') ?? 0;
    //   activeUsers.value = _storage!.read<int>('overview_activeUsers') ?? 0;
    //   workingUsers.value = _storage!.read<int>('overview_workingUsers') ?? 0;
    //   pendingAmount.value = _storage!.read<double>('overview_pendingAmount') ?? 0.0;
    //   pendingUsersCount.value = _storage!.read<int>('overview_pendingCount') ?? 0;
    // } catch (e) {
    //   // Ignored for cache
    // }
  }

  /// 2. Fetch Latest Data from API (Dummy Implementation)
  Future<void> _fetchFromAPI() async {
    error.value = '';
    try {
      // Dummy Network Delay
      await Future.delayed(const Duration(seconds: 1));

      // Dummy Backend Response
      final response = {
        'totalUsers': 1250,
        'activeUsers': 890,
        'workingUsers': 34,
        'pendingAmount': 4200.0,
        'pendingUsersCount': 45,
        'userGrowth': [
          {'label': 'Mon', 'value': 20.0},
          {'label': 'Tue', 'value': 25.0},
          {'label': 'Wed', 'value': 35.0},
          {'label': 'Thu', 'value': 30.0},
          {'label': 'Fri', 'value': 50.0},
          {'label': 'Sat', 'value': 40.0},
          {'label': 'Sun', 'value': 55.0},
        ],
        'liveActivity': [
          {
            'userName': 'John Doe',
            'action': 'Logged in',
            'time': 'Just now',
            'isEntry': true,
          },
          {
            'userName': 'Sarah Smith',
            'action': 'Started workout',
            'time': '5 min ago',
            'isEntry': true,
          },
          {
            'userName': 'Mike Johnson',
            'action': 'Left gym',
            'time': '12 min ago',
            'isEntry': false,
          },
        ],
      };

      // 3. Update UI instantly
      totalUsers.value = response['totalUsers'] as int;
      activeUsers.value = response['activeUsers'] as int;
      workingUsers.value = response['workingUsers'] as int;
      pendingAmount.value = response['pendingAmount'] as double;
      pendingUsersCount.value = response['pendingUsersCount'] as int;

      final rawChart = response['userGrowth'] as List;
      userGrowthData.value = rawChart
          .map((e) => ChartData(e['label'], e['value']))
          .toList();

      final rawActivity = response['liveActivity'] as List;
      liveActivityList.value = rawActivity
          .map(
            (e) => ActivityLog(
              e['userName'],
              e['action'],
              e['time'],
              e['isEntry'],
            ),
          )
          .toList();

      // 4. Save to local cache
      _saveToCache();
    } catch (e) {
      error.value = 'Failed to sync with server. Displaying cached data.';
    }
  }

  void _saveToCache() {
    // if (_storage == null) return;
    // try {
    //   _storage!.write('overview_totalUsers', totalUsers.value);
    //   _storage!.write('overview_activeUsers', activeUsers.value);
    //   _storage!.write('overview_workingUsers', workingUsers.value);
    //   _storage!.write('overview_pendingAmount', pendingAmount.value);
    //   _storage!.write('overview_pendingCount', pendingUsersCount.value);
    // } catch (e) {
    //   // Ignored for cache
    // }
  }
}
