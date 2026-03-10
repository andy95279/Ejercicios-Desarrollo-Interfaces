import 'dart:async';
import '../models/user.dart';

class AuthService {
  User? _currentUser;

  User? get currentUser => _currentUser;

  Future<bool> login(String email, String password) async {
    // Simular un retraso de red
    await Future.delayed(const Duration(seconds: 1));

    // Simulación simple: cualquier contraseña de más de 6 caractéres funciona
    if (password.length >= 6) {
      _currentUser = User(id: '1', email: email, name: email.split('@')[0]);
      return true;
    }
    return false;
  }

  Future<bool> loginWithPhone(String phoneNumber) async {
    await Future.delayed(const Duration(seconds: 1));
    // Simular login exitoso
    _currentUser = User(
      id: '1',
      email: 'user@example.com',
      name: 'Usuario Demo',
      phoneNumber: phoneNumber,
    );
    return true;
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
    await Future.delayed(const Duration(seconds: 1));
    _currentUser = User(
      id: '1',
      email: email,
      name: name,
      lastName: lastName,
      phoneNumber: phoneNumber,
      age: age,
      language: language,
    );
    return true;
  }

  Future<bool> verifyAccount(String code) async {
    await Future.delayed(const Duration(seconds: 1));
    return code == '123456'; // Código de verificación actualizado
  }

  Future<void> logout() async {
    _currentUser = null;
  }

  Future<bool> updateProfile(User updatedUser) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = updatedUser;
    return true;
  }
}
