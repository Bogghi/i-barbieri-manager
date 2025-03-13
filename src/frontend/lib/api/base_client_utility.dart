import 'package:http/http.dart';
import 'package:frontend/meta/constants.dart';
import 'package:frontend/meta/tokens.dart';
import 'package:frontend/providers/auth_provider.dart';


enum Status { ok, forbidden, error }

abstract class BaseClientUtility {

  static Future<Uri> buildUrl(String path) async {
    return Uri.parse(await Constants.baseUrl()+path);
  }

  static Map<String,String> parseHeaders(Map<String, dynamic> header) {
    final Map<String, String> parsedHeader = {};

    header.forEach((key, value) {
      parsedHeader[key] = value.toString();
    });

    return parsedHeader;
  }

  static Status getStatusFromResponse(Response response) {
    if (response.statusCode == 200) {
      return Status.ok;
    } else if (response.statusCode == 403) {
      return Status.forbidden;
    } else {
      return Status.error;
    }
  }

  static Future<Response> getData(String path, Map<String, dynamic> headers) async {
    final url = await buildUrl(path);
    final token = Tokens().oauthToken;

    if(token != null) {
      headers['Authorization'] = "Bearer $token";
    }

    return await get(
        url,
        headers: parseHeaders(headers)
    );
  }

  static Future<Response> postData(String path, Map<String, dynamic> headers, Object body) async {
    final url = await buildUrl(path);
    final token = Tokens().oauthToken;

    if(token != null) {
      headers['Authorization'] = "Bearer $token";
    }

    return await post(
        url,
        headers: parseHeaders(headers),
        body: body
    );
  }
}