import 'package:get/get.dart';

class ChatController extends GetxController {
  final RxList<dynamic> activeChats = [].obs;

  @override
  void onInit() {
    super.onInit();
    _loadChats();
  }

  void _loadChats() {
    activeChats.value = [
      {'name': 'Admin Gym', 'role': 'Admin', 'lastMessage': 'Welcome to FitFlow!', 'time': '10:00 AM', 'unread': 1},
      {'name': 'Coach Mark', 'role': 'Trainer', 'lastMessage': 'Don\'t forget leg day.', 'time': 'Yesterday', 'unread': 0},
    ];
  }
}
