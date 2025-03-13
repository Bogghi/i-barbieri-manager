import 'package:frontend/meta/utilities.dart';
import 'package:frontend/meta/web_interface.dart';

class Tokens {
  String? oauthToken;
  String? refreshToken;

  static final Tokens _tokens = Tokens._internal();

  factory Tokens() {
    _tokens.fetchToken();
    return _tokens;
  }

  Tokens._internal();

  void fetchToken() {
    if(Utilities.isWeb())  {
      oauthToken = WebInterface().getFromSessionStorage('oauth_token');
      refreshToken = WebInterface().getFromLocalStorage('refresh_token');
    }
  }
}