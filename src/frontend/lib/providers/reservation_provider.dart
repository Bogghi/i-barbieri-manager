import 'package:flutter/material.dart';

class ReservationProvider extends ChangeNotifier {
  int _reservationStep = 0;
  int _service = -1;
  int ?_barber;
  DateTime ?_date;
  int ?_slot;
  String ?_number;

  ReservationProvider();

  void setStep(int s) {
    _reservationStep = s;
    notifyListeners();
  }
  int getStep() => _reservationStep;

  int getServiceSelected() => _service;
  void setService(int service) {
    _service = service;
    _reservationStep = 1;
    notifyListeners();
  }

  int? getBarberSelected() => _barber;
  void setBarber(int barber) {
    _barber = barber;
    _reservationStep = 2;
    notifyListeners();
  }

  DateTime? getDate() => _date;
  void setDate(DateTime date) {
    _date = date;
    _reservationStep = 3;
    notifyListeners();
  }

  void setSlot(int slot) {
    _slot = slot;
    _reservationStep = 4;
    notifyListeners();
  }
  int? getSlot() => _slot;

  void setNumber(String number) {
    _number = number;
    notifyListeners();
  }
  String? getNumber() => _number;
}