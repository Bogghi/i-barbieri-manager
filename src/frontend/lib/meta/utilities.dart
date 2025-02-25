import 'package:flutter/foundation.dart' show kIsWeb;

class Utilities {
  static bool isWeb() {
    return kIsWeb;
  }

  static String readableEurVal(int price) {
    double parsedPrice = price / 100;

    return "${parsedPrice.toStringAsFixed(2)} €";
  }
}