import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;
  int _accentColorIndex = 0;
  int _chatBackgroundIndex = 0;

  ThemeMode get themeMode => _themeMode;
  int get accentColorIndex => _accentColorIndex;
  int get chatBackgroundIndex => _chatBackgroundIndex;

  SettingsProvider() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt('themeMode') ?? 2; // Default to dark
    _themeMode = ThemeMode.values[themeIndex];
    _accentColorIndex = prefs.getInt('accentColorIndex') ?? 0;
    _chatBackgroundIndex = prefs.getInt('chatBackgroundIndex') ?? 0;
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeMode', mode.index);
    notifyListeners();
  }

  Future<void> setAccentColor(int index) async {
    _accentColorIndex = index;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('accentColorIndex', index);
    notifyListeners();
  }

  Future<void> setChatBackground(int index) async {
    _chatBackgroundIndex = index;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('chatBackgroundIndex', index);
    notifyListeners();
  }
}
