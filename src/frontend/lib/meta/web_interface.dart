import 'dart:html';

class WebInterface {
  static final WebInterface _interface = WebInterface._internal();

  factory WebInterface() {
    return _interface;
  }

  WebInterface._internal();

  void addToLocalStorage(String key, String value) {
    window.localStorage[key] = value;
  }
  String? getFromLocalStorage(String key) {
    return window.localStorage[key];
  }

  void addToSessionStorage(String key, String value) {
    window.sessionStorage[key] = value;
  }
  String? getFromSessionStorage(String key) {
    return window.sessionStorage[key];
  }
}