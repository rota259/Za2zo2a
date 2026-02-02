import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginViewModel2 extends ChangeNotifier {
  final AuthService _authService;
  
  LoginViewModel2({AuthService? authService}) 
      : _authService = authService ?? AuthService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _rememberMe = false;
  bool get rememberMe => _rememberMe;

  void toggleRememberMe(bool? value) {
    if (value != null) {
      _rememberMe = value;
      notifyListeners();
    }
  }

  Future<bool> login() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      if (emailController.text.isEmpty || passwordController.text.isEmpty) {
        throw 'Please fill all fields';
      }

      await _authService.signIn(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
