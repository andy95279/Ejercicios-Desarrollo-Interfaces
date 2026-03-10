class TranslationService {
  Future<String> translate(String text, String targetLanguage) async {
    // Mock translation logic
    await Future.delayed(const Duration(milliseconds: 300));

    // Simple mock logic: if it looks like English, return a Spanish version (or vice-versa)
    if (text.toLowerCase().contains('hello')) return 'hola';
    if (text.toLowerCase().contains('how are you')) return '¿cómo estás?';
    if (text.toLowerCase().contains('thanks')) return 'gracias';

    return "[Traducido a $targetLanguage]: $text";
  }
}
