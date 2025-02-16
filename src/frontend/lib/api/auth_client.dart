import 'dart:convert';

import 'package:http/http.dart';
import 'package:frontend/api/base_client_utility.dart';

abstract class AuthClient {
  static Future<Map<String, dynamic>> login(String email, String password) async {
    Map<String, dynamic> tokens = {'oauth_token': null, 'refresh_token': null};
    Response response = await BaseClientUtility.postData(
      '/barbers/login', {}, {'email': email, 'password': password}
    );

    final Status status = BaseClientUtility.getStatusFromResponse(response);
    if(status == Status.ok) {
      var data = jsonDecode(response.body);
      if(data.containsKey('oauth_token')) {
        tokens['oauth_token'] = data['oauth_token'];
      }
      if(data.containsKey('refresh_token')) {
        tokens['refresh_token'] = data['refresh_token'];
      }
    }
    
    return tokens;
  }

  static Future<Map<String, String?>> loginByRefreshToken(String refreshToken) async {
    Map<String, String?> tokens = {'oauth_token': null, 'refresh_token': null};

    Response response = await BaseClientUtility.postData(
      '/barbers/refresh', {}, {'refresh_token': refreshToken}
    );

    final Status status = BaseClientUtility.getStatusFromResponse(response);
    if(status == Status.ok) {
      var data = jsonDecode(response.body);
      if(data.containsKey('oauth_token')) {
        tokens['oauth_token'] = data['oauth_token'];
      }
      if(data.containsKey('refresh_token')) {
        tokens['refresh_token'] = data['refresh_token'];
      }
    }

    return tokens;
  }

  static Future<bool> signup(String email, String password) async {
    final bool signupStatus;
    Response response = await BaseClientUtility.postData(
      '/barbers/signup', {}, {'email': email, 'password': password}
    );

    final Status status = BaseClientUtility.getStatusFromResponse(response);
    if(status == Status.ok) {
      var data = jsonDecode(response.body);
      signupStatus = data.containsKey('result') && data['result'] == 'OK' ? true : false;
    }
    else {
      signupStatus = false;
    }

    return signupStatus;
  }
}