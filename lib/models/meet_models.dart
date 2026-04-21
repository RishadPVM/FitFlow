

import 'package:fitflow/models/gym_model.dart';

class ChatConversation {
  final String id;
  final GymModel contact;
  String lastMessage;
  String time;
  int unread;

  ChatConversation({
    required this.id,
    required this.contact,
    this.lastMessage = '',
    this.time = '',
    this.unread = 0,
  });
}

class ChatMessage {
  final String id;
  final String text;
  final bool isSentByMe;
  final String time;
  final String type; // 'text' | 'voice'
  final String duration;

  ChatMessage({
    required this.id,
    this.text = '',
    required this.isSentByMe,
    required this.time,
    this.type = 'text',
    this.duration = '0:00',
  });
}
