import 'dart:async';

import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';

class MemberModel {
  final String id;
  final String name;
  final String phone;

  MemberModel({required this.id, required this.name, required this.phone});
}

class AttendanceController extends GetxController {
  // 🔹 SESSION STATE
  final isSessionActive = true.obs;

  // 🔹 QR SYSTEM
  final sessionId = ''.obs;
  final qrData = ''.obs;
  final qrCountdown = 30.obs;
  Timer? _qrTimer;

  // 🔹 STATS
  final totalPresentCount = 0.obs;

  // 🔹 SEARCH / MANUAL ENTRY
  final searchQuery = ''.obs;
  final isLoading = false.obs;

  // 🔹 MEMBERS (MOCK → replace with API)
  final List<MemberModel> _allMembers = [
    MemberModel(id: '1', name: 'John Doe', phone: '555-0101'),
    MemberModel(id: '2', name: 'Jane Smith', phone: '555-0102'),
    MemberModel(id: '3', name: 'Mike Johnson', phone: '555-0103'),
    MemberModel(id: '4', name: 'Sarah Williams', phone: '555-0104'),
    MemberModel(id: '5', name: 'Chris Hemsworth', phone: '555-0105'),
    MemberModel(id: '6', name: 'Emma Watson', phone: '555-0106'),
    MemberModel(id: '7', name: 'Tom Hardy', phone: '555-0107'),
  ];

  // 🔥 FIXED: RxSet (important)
  final RxSet<String> presentMemberIds = <String>{}.obs;

  // 🔹 FILTERED MEMBERS
  List<MemberModel> get filteredMembers {
    if (searchQuery.value.isEmpty) return [];

    final query = searchQuery.value.toLowerCase();

    return _allMembers.where((member) {
      if (presentMemberIds.contains(member.id)) return false;

      return member.name.toLowerCase().contains(query) ||
          member.phone.contains(query);
    }).toList();
  }

  @override
  void onInit() {
    super.onInit();

    startSession();

    // demo data
    presentMemberIds.addAll(['1', '5']);
    totalPresentCount.value = presentMemberIds.length;
  }

  @override
  void onClose() {
    _qrTimer?.cancel();
    super.onClose();
  }

  // 🔥 SESSION CONTROL
  void startSession() {
    isSessionActive.value = true;
    _generateNewSession();
    _startQrTimer();
  }

  void stopSession() {
    isSessionActive.value = false;
    _qrTimer?.cancel();
  }

  // 🔥 QR GENERATION
  void _generateNewSession() {
    final now = DateTime.now();

    sessionId.value =
        'SES-${now.millisecondsSinceEpoch.toString().substring(5)}';

    qrData.value = 'fitflow://attendance/session/${sessionId.value}';

    qrCountdown.value = 30;
  }

  void _startQrTimer() {
    _qrTimer?.cancel();

    _qrTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isSessionActive.value) return;

      if (qrCountdown.value > 1) {
        qrCountdown.value--;
      } else {
        _generateNewSession();
      }
    });
  }

  void refreshQrContent() {
    _generateNewSession();
    _startQrTimer();
  }

  // 🔥 MANUAL ENTRY (SECURE)
  void markPresent(MemberModel member, String reason) {
    if (!isSessionActive.value) {
      Get.snackbar("Error", "Session is not active");
      return;
    }

    if (presentMemberIds.contains(member.id)) {
      Get.snackbar(
        'Warning',
        '${member.name} already marked',
        backgroundColor: AppColors.secondaryGreen.withValues(alpha: 0.1),
      );
      return;
    }

    if (reason.isEmpty) {
      Get.snackbar("Error", "Reason required");
      return;
    }

    presentMemberIds.add(member.id);
    totalPresentCount.value = presentMemberIds.length;

    searchQuery.value = '';

    Get.back();

    Get.snackbar(
      'Success',
      'Marked: ${member.name}',
      backgroundColor: AppColors.success.withValues(alpha:0.1),
    );
  }
}
