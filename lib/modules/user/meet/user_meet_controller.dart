import 'package:fitflow/models/gym_model.dart';
import 'package:fitflow/models/meet_models.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class UserMeetController extends GetxController {
  
    // Meet Home State
  final activeMeets = <ChatConversation>[].obs;
  final searchQuery = ''.obs;

    // Active Chat State
  final currentChatPartner = Rxn<ChatConversation>();
  final chatMessages = <ChatMessage>[].obs;
  final textController = TextEditingController();
  final isTyping = false.obs;
  final isRecording = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadMeets();
  }

  void _loadMeets() {
    activeMeets.value = [
      ChatConversation(
        id: 'c1',
        contact: GymModel(
          id: 'g1',
          name: 'Titan Fitness Elite',
          role: 'Gym Partner',
          status: 'Online',
        ),
        lastMessage: 'Sure, we can do a joint pass.',
        time: '11:30 AM',
        unread: 2,
      ),
      ChatConversation(
        id: 'c2',
        contact: GymModel(
          id: 'g2',
          name: 'Iron Core Gym',
          role: 'Gym Branch',
          status: 'Offline',
        ),
        lastMessage: 'Equipment maintenance scheduled.',
        time: 'Yesterday',
        unread: 0,
      ),
    ];
  }



 List<ChatConversation> get filteredMeets {
    if (searchQuery.value.trim().isEmpty) return activeMeets;
    return activeMeets.where((meet) => 
      meet.contact.name.toLowerCase().contains(searchQuery.value.toLowerCase())
    ).toList();
  }


  // Actions
  void openChat(ChatConversation meet) {
    // Mark as read
    meet.unread = 0;
    activeMeets.refresh();
    
    currentChatPartner.value = meet;
    _loadMockMessages();
  }

  void startNewChat(GymModel gym) {
    // Check if chat already exists
    final exists = activeMeets.firstWhereOrNull((m) => m.contact.id == gym.id);
    if (exists != null) {
      openChat(exists);
    } else {
      final newChat = ChatConversation(
        id: 'c_${DateTime.now().millisecondsSinceEpoch}',
        contact: gym,
        lastMessage: '',
        time: 'Just now',
      );
      activeMeets.insert(0, newChat);
      openChat(newChat);
    }
  }

  void _loadMockMessages() {
    chatMessages.value = [
      ChatMessage(
        id: 'm1',
        text: 'Hey there! How is the new equipment working out for you?',
        isSentByMe: true,
        time: '11:15 AM',
      ),
      ChatMessage(
        id: 'm2',
        text: 'It is amazing. The members love the new cardio section.',
        isSentByMe: false,
        time: '11:20 AM',
      ),
      ChatMessage(
        id: 'm3',
        text: 'Great! Are you open to doing a joint pass for the weekend?',
        isSentByMe: true,
        time: '11:25 AM',
      ),
      ChatMessage(
        id: 'm4',
        text: 'Sure, we can do a joint pass.',
        isSentByMe: false,
        time: '11:30 AM',
      ),
      ChatMessage(
        id: 'm5',
        isSentByMe: false,
        time: '11:32 AM',
        type: 'voice',
        duration: '0:14',
      ),
    ];
  }

  void sendMessage() {
    if (textController.text.trim().isEmpty) return;

    final newMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: textController.text.trim(),
      isSentByMe: true,
      time: 'Just now',
    );

    chatMessages.add(newMessage);
    
    // Update last message in active meets
    if (currentChatPartner.value != null) {
      final chat = currentChatPartner.value!;
      chat.lastMessage = textController.text.trim();
      chat.time = 'Just now';
      
      final idx = activeMeets.indexOf(chat);
      if (idx != -1) {
        activeMeets.removeAt(idx);
        activeMeets.insert(0, chat); // move to top
      }
    }
    
    textController.clear();
    isTyping.value = false;
  }   

}