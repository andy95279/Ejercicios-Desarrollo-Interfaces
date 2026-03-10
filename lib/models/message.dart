class Message {
  final String id;
  final String senderId;
  final String text;
  final String? originalText;
  final String? sourceLanguage;
  final DateTime timestamp;
  bool showOriginal;
  final bool isAudio;
  final String? audioDuration;

  Message({
    required this.id,
    required this.senderId,
    required this.text,
    this.originalText,
    this.sourceLanguage,
    required this.timestamp,
    this.showOriginal = false,
    this.isAudio = false,
    this.audioDuration,
  });
}
