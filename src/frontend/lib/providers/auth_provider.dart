import 'package:flutter/material.dart';
import 'package:frontend/api/auth_client.dart';

class AuthProvider extends ChangeNotifier {
  bool _passwordVisible = false;
  bool _credentialError = false;
  String? _jwtToken;
  String? _errorMsg;

  bool passwordVisible() => _passwordVisible;
  void togglePasswordVisibility() {
    _passwordVisible = !_passwordVisible;
    notifyListeners();
  }

  bool credentialError() => _credentialError;
  String? jwtToken() => _jwtToken;
  String? errorMsg() => _errorMsg;
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
        _errorMsg = "Le credenziali inserite non sono valide";
      }
    }
    notifyListeners();

  }

  Future<void> signup(String email, String password, BuildContext context) async {

    if(email.isEmpty || password.isEmpty){
      _credentialError = true;
      notifyListeners();
      return;
    }
    else {
      bool signupResult = await AuthClient.signup(email, password);
      if(signupResult && context.mounted) {
        verifyCredentials(email, password, context);
      }
      else {
        _credentialError = true;
        _errorMsg = "Le credenziali inserite non sono valide per la registrazione";
        notifyListeners();
      }
    }

  }

}