import 'package:web/web.dart';

class WebInterface {
  static final WebInterface _interface = WebInterface._internal();

  factory WebInterface() {
    return _interface;
  }

  WebInterface._internal();

  void addToLocalStorage(String key, String value) {
    window.localStorage.setItem(key, value);
  }
  String? getFromLocalStorage(String key) {
    return window.localStorage.getItem(key);
  }

  void addToSessionStorage(String key, String value) {
    window.sessionStorage.setItem(key, value);
  }
  String? getFromSessionStorage(String key) {
    return window.sessionStorage.getItem(key);
  }
}