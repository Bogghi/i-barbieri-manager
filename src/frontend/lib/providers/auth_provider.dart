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
  String? oauthToken() => _oauthToken;
  String? errorMsg() => _errorMsg;
  String? refreshToken() => _refreshToken;
  Future<void> verifyCredentials(String email, String password) async {

    if(email.isEmpty || password.isEmpty){
      _credentialError = true;
    }
    else {
      final Map<String, dynamic> tokens = await AuthClient.login(email, password);
      _oauthToken = tokens['oauth_token'];
      _refreshToken = tokens['refresh_token'];

      if(_oauthToken != null) {
        if(Utilities.isWeb()) {
          WebInterface().addToSessionStorage('oauth_token', _oauthToken!);
          if(_refreshToken != null) {
            WebInterface().addToLocalStorage('refresh_token', _refreshToken!);
          }
        }
      }
      else {
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
        verifyCredentials(email, password);
      }
      else {
        _credentialError = true;
        _errorMsg = "Le credenziali inserite non sono valide per la registrazione";
        notifyListeners();
      }
    }

  }

  Future<void> fetchTokensFromStorage(BuildContext context) async {
    if(Utilities.isWeb()) {
      _oauthToken = WebInterface().getFromSessionStorage('oauth_token');
      _refreshToken = WebInterface().getFromLocalStorage('refresh_token');

      if(_refreshToken != null && _oauthToken == null) {
        final tokens = await AuthClient.loginByRefreshToken(_refreshToken!);

        _oauthToken = tokens['oauth_token'];
        _refreshToken = tokens['refresh_token'];

        if(Utilities.isWeb()) {
          WebInterface().addToSessionStorage('oauth_token', _oauthToken!);
          if(_refreshToken != null) {
            WebInterface().addToLocalStorage('refresh_token', _refreshToken!);
          }
        }
      }
    }
  }

}