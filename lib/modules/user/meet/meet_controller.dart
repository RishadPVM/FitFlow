import 'package:get/get.dart';

class UserMeetController extends GetxController {
  final RxList<dynamic> activeChats = [].obs;

  @override
  void onInit() {
    super.onInit();
    _loadChats();
  }

  void _loadChats() {
    activeChats.value = [
      {'name': 'FitFlow Support', 'role': 'System', 'lastMessage': 'Welcome to FitFlow! Find a gym to get started.', 'time': '10:00 AM', 'unread': 1},
    ];
  }
}
