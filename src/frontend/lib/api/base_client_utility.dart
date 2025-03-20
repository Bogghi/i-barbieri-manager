import 'package:dio/dio.dart';
import 'package:frontend/meta/constants.dart';
import 'package:frontend/meta/tokens.dart';


enum Status { ok, forbidden, error }

class BaseClientUtility {
  final dio = Dio();

  static final BaseClientUtility _baseClient = BaseClientUtility._internal();

  factory BaseClientUtility() {
    return _baseClient;
  }

  BaseClientUtility._internal();

  Future<String> buildUrl(String path) async {
    return await Constants.baseUrl()+path;
  }

  Map<String,String> parseHeaders(Map<String, dynamic> header) {
    final Map<String, String> parsedHeader = {};

    header.forEach((key, value) {
      parsedHeader[key] = value.toString();
    });

    return parsedHeader;
  }
  Map<String, String> parseBody(Map<String, dynamic> body) {
    final Map<String, String> parsedBody = {};

    body.forEach((key, value) {
      parsedBody[key] = value.toString();
    });

    print(parsedBody);

    return parsedBody;
  }

  Status getStatusFromResponse(Response response) {
    if (response.statusCode == 200) {
      return Status.ok;
    } else if (response.statusCode == 403) {
      return Status.forbidden;
    } else {
      return Status.error;
    }
  }

  Future<String> getData(String path, Map<String, dynamic> headers) async {
    final url = await buildUrl(path);
    final token = Tokens().oauthToken;

    if(token != null) {
      headers['Authorization'] = "Bearer $token";
    }
    headers['Access-Control-Allow-Origin'] = "*";

    var response = await dio.get(url,options: Options(
      headers: headers,
    ));
    return response.data.toString();
  }

  Future<String> postData(String path, Map<String, dynamic> headers, Map<String, dynamic> body) async {
    final url = await buildUrl(path);
    final token = Tokens().oauthToken;

    if(token != null) {
      headers['Authorization'] = "Bearer $token";
    }
    headers['Access-Control-Allow-Origin'] = '*';

    var response = await dio.post(
      url,
      data: body,
      options: Options(
        headers: headers,
      )
    );
    return response.data.toString();
  }
}