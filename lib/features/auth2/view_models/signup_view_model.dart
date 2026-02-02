import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class SignupViewModel2 extends ChangeNotifier {
  final AuthService _authService;

  SignupViewModel2({AuthService? authService})
      : _authService = authService ?? AuthService();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController(); 
  final TextEditingController birthDayController = TextEditingController();
  
  String _gender = 'Male';
  String get gender => _gender;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void setGender(String? value) {
    if (value != null) {
      _gender = value;
      notifyListeners();
    }
  }

  Future<bool> signup() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      if (emailController.text.isEmpty || passwordController.text.isEmpty || nameController.text.isEmpty) {
        throw 'Please fill all mandatory fields';
      }

      await _authService.signUp(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      
      // TODO: Save other details (name, phone, gender, birthday) to Firestore if required later.
      
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
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    birthDayController.dispose();
    super.dispose();
  }
}
