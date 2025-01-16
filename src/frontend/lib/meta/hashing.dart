import 'package:crypt/crypt.dart';
import 'package:frontend/meta/constants.dart';

abstract class Hashing {
  static Future<String> hashString(String toHash) async {
    return Crypt.sha256(toHash, salt: await Constants.salt()).toString();
  }
}