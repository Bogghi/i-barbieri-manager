import 'package:flutter/material.dart';
import 'package:frontend/api/auth_client.dart';

class AuthProvider extends ChangeNotifier {
  bool _passwordVisible = false;
  bool _credentialError = false;
  String? _jwtToken;

  bool passwordVisible() => _passwordVisible;
  void togglePasswordVisibility() {
    _passwordVisible = !_passwordVisible;
    notifyListeners();
  }

  bool credentialError() => _credentialError;
  String? jwtToken() => _jwtToken;
  Future<void> verifyCredentials(String email, String password, BuildContext context) async {

    if(email.isEmpty || password.isEmpty){
      _credentialError = true;
    }
    else {
      _jwtToken = await AuthClient.login(email, password);

      if(_jwtToken != null && context.mounted) {
        Navigator.pushReplacementNamed(context, '/console');
      }else {
        _credentialError = true;
      }
    }
    notifyListeners();
  }

}