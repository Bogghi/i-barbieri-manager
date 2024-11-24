import 'package:flutter/material.dart';

class ReservationProvider extends ChangeNotifier {
  int _service = -1;

  ReservationProvider();

  int getServiceSelected() {
    return _service;
  }
  void setService(int service) {
    _service = service;
    notifyListeners();
  }
}