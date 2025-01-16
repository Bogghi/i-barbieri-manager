import 'package:flutter/material.dart';
import 'package:frontend/api/auth_client.dart';

class AuthProvider extends ChangeNotifier {
  bool _passwordVisible = false;
  bool _usernameError = false;
  bool _passwordError = false;
  String? _jwtToken = null;

  bool passwordVisible() => _passwordVisible;
  void setPasswordVisible(bool status) {
    _passwordVisible = status;
    notifyListeners();
  }

  bool usernameError() => _usernameError;
  void setUsernameError(bool status) {
    _usernameError = status;
    notifyListeners();
  }

  bool passwordError() => _passwordError;
  void setPasswordError(bool status) {
    _passwordError = status;
    notifyListeners();
  }

  Future<void> verifyCredentials(String email, String password) async {
    _jwtToken = await AuthClient.login(email, password);
    notifyListeners();
  }
}