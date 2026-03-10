import '../models/chat.dart';
import '../models/message.dart';

class ChatService {
  final List<Chat> _mockChats = [
    Chat(
      id: '1',
      participantName: 'Emma Wilson',
      participantLanguage: 'GB',
      participantStatus: 'Desconectado',
      lastMessage: '¡gracias por tu mensaje!',
      lastMessageTime: DateTime.now().subtract(const Duration(minutes: 5)),
      messages: [
        Message(
          id: 'm1',
          senderId: '2',
          text: '¡gracias por tu mensaje!',
          originalText: 'thanks for your message!',
          sourceLanguage: 'GB',
          timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        ),
      ],
    ),
  ];

  Future<List<Chat>> getChats() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockChats;
  }

  Future<void> sendMessage(String chatId, String text) async {
    final chat = _mockChats.firstWhere((c) => c.id == chatId);
    final newMessage = Message(
      id: DateTime.now().toString(),
      senderId: '1',
      text: text,
      timestamp: DateTime.now(),
    );
    chat.messages.add(newMessage);
  }

  Future<void> sendAudioMessage(String chatId, String duration) async {
    final chat = _mockChats.firstWhere((c) => c.id == chatId);
    final newMessage = Message(
      id: DateTime.now().toString(),
      senderId: '1',
      text: 'Mensaje de audio',
      timestamp: DateTime.now(),
      isAudio: true,
      audioDuration: duration,
    );
    chat.messages.add(newMessage);
  }
}
