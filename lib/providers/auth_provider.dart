import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;
  bool _isLoading = false;

  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _user != null;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final success = await _authService.login(email, password);
    if (success) {
      _user = _authService.currentUser;
    }

    _isLoading = false;
    notifyListeners();
    return success;
  }

  Future<bool> loginWithPhone(String phoneNumber) async {
    _isLoading = true;
    notifyListeners();

    final success = await _authService.loginWithPhone(phoneNumber);
    if (success) {
      _user = _authService.currentUser;
    }

    _isLoading = false;
    notifyListeners();
    return success;
  }

  Future<bool> register({
    required String email,
    required String password,
    required String name,
    String? lastName,
    String? phoneNumber,
    int? age,
    String? language,
  }) async {
    _isLoading = true;
    notifyListeners();

    final success = await _authService.register(
      email: email,
      password: password,
      name: name,
      lastName: lastName,
      phoneNumber: phoneNumber,
      age: age,
      language: language,
    );
    if (success) {
      _user = _authService.currentUser;
    }

    _isLoading = false;
    notifyListeners();
    return success;
  }

  Future<bool> verify(String code) async {
    return await _authService.verifyAccount(code);
  }

  void logout() {
    _authService.logout();
    _user = null;
    notifyListeners();
  }

  Future<bool> updateUser(User updatedUser) async {
    _isLoading = true;
    notifyListeners();

    final success = await _authService.updateProfile(updatedUser);
    if (success) {
      _user = updatedUser;
    }

    _isLoading = false;
    notifyListeners();
    return success;
  }
}
