import 'dart:convert';

import 'package:http/http.dart';
import 'package:frontend/api/base_client_utility.dart';

abstract class AuthClient {
  static Future<String?> login(String email, String password) async {
    final String? jwtToken;
    Response response = await BaseClientUtility.postData(
      '/barbers/login', {}, {'email': email, 'password': password}
    );

    final Status status = BaseClientUtility.getStatusFromResponse(response);
    if(status == Status.ok) {
      var data = jsonDecode(response.body);
      jwtToken = data['token'];
    }else {
      jwtToken = null;
    }
    
    return jwtToken;
  }
}