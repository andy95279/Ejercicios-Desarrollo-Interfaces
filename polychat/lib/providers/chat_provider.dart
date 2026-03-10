import 'package:flutter/material.dart';
import '../models/chat.dart';
import '../services/chat_service.dart';

class ChatProvider extends ChangeNotifier {
  final ChatService _chatService = ChatService();
  List<Chat> _chats = [];
  bool _isLoading = false;

  List<Chat> get chats => _chats;
  bool get isLoading => _isLoading;

  Future<void> loadChats() async {
    _isLoading = true;
    notifyListeners();

    _chats = await _chatService.getChats();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> sendMessage(String chatId, String text) async {
    await _chatService.sendMessage(chatId, text);
    notifyListeners();
  }

  Future<void> sendAudioMessage(String chatId, String duration) async {
    await _chatService.sendAudioMessage(chatId, duration);
    notifyListeners();
  }

  void toggleOriginal(String chatId, String messageId) {
    final chat = _chats.firstWhere((c) => c.id == chatId);
    final message = chat.messages.firstWhere((m) => m.id == messageId);
    message.showOriginal = !message.showOriginal;
    notifyListeners();
  }
}
