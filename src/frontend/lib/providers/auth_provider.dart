import 'package:flutter/material.dart';

import 'package:frontend/api/auth_client.dart';
import 'package:frontend/meta/web_interface.dart';
import 'package:frontend/meta/utilities.dart';

class AuthProvider extends ChangeNotifier {
  bool _passwordVisible = false;
  bool _credentialError = false;
  String? _oauthToken;
  String? _refreshToken;
  String? _errorMsg;

  bool passwordVisible() => _passwordVisible;
  void togglePasswordVisibility() {
    _passwordVisible = !_passwordVisible;
    notifyListeners();
  }

  bool credentialError() => _credentialError;
  String? jwtToken() => _oauthToken;
  String? errorMsg() => _errorMsg;
  String? refreshToken() => _refreshToken;
  Future<void> verifyCredentials(String email, String password, BuildContext context) async {

    if(email.isEmpty || password.isEmpty){
      _credentialError = true;
    }
    else {
      final Map<String, dynamic> tokens = await AuthClient.login(email, password);
      _oauthToken = tokens['oauth_token'];
      _refreshToken = tokens['refresh_token'];

      if(_oauthToken != null && context.mounted) {
        if(Utilities.isWeb()) {
          WebInterface().addToLocalStorage('oauth_token', _oauthToken!);
          if(_refreshToken != null) {
            WebInterface().addToSessionStorage('refresh_token', _refreshToken!);
          }
        }
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