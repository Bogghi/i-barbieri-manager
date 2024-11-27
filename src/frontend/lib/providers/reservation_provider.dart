import 'package:flutter/material.dart';

class ReservationProvider extends ChangeNotifier {
  int _service = -1;
  int ?_barber = null;

  ReservationProvider();

  int getServiceSelected() {
    return _service;
  }
  int? getBarberSelected() {
    return _barber;
  }

  void setService(int service) {
    _service = service;
    notifyListeners();
  }
  void setBarber(int barber) {
    _barber = barber;
    notifyListeners();
  }
}