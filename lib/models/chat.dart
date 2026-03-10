import 'message.dart';

class Chat {
  final String id;
  final String participantName;
  final String? participantLanguage;
  final String? participantStatus;
  final String? lastMessage;
  final DateTime? lastMessageTime;
  final List<Message> messages;

  Chat({
    required this.id,
    required this.participantName,
    this.participantLanguage,
    this.participantStatus,
    this.lastMessage,
    this.lastMessageTime,
    this.messages = const [],
  });
}
