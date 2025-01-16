import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class Constants {
  static Future<String> baseUrl() async {
    await dotenv.load(fileName: '.env');
    return dotenv.env['BASE_URL'] ?? '';
  }
  static Future<String> salt() async {
    await dotenv.load(fileName: '.env');
    return dotenv.env['SALT'] ?? '';
  }
}