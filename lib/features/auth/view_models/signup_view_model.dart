import 'package:flutter/material.dart';
import 'package:flutter_tasks_mostafa/features/auth/services/auth_services.dart';

class SignupViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  bool isLoading = false;
  String? error;

  Future<bool> signup(String email, String pass) async {
    isLoading = true; error = null; notifyListeners();
    try {
      await _authService.signUp(email, pass);
      isLoading = false; notifyListeners();
      return true;
    } catch (e) {
      error = e.toString();
      isLoading = false; notifyListeners();
      return false;
    }
  }
}