import 'package:flutter/material.dart';

class ReservationProvider extends ChangeNotifier {
  int _reservationStep = 0;
  int _service = -1;
  int ?_barber = null;
  DateTime ?_date = null;
  List<TimeOfDay> _slot = [];

  ReservationProvider();

  void setStep(int s) {
    _reservationStep = s;
    notifyListeners();
  }
  int getStep() {
    return _reservationStep;
  }

  int getServiceSelected() {
    return _service;
  }
  void setService(int service) {
    _service = service;
    _reservationStep = 1;
    notifyListeners();
  }

  int? getBarberSelected() {
    return _barber;
  }
  void setBarber(int barber) {
    _barber = barber;
    _reservationStep = 2;
    notifyListeners();
  }

  DateTime? getDate() {
    return _date;
  }
  void setDate(DateTime date){
    _date = date;
    _reservationStep = 3;
    notifyListeners();
  }

  void setSlot(List<TimeOfDay> slot) {
    _slot = slot;
    _reservationStep = 4;
    notifyListeners();
  }
  String getSlot(BuildContext context) {
    var slot = _slot.map((slotTime) => slotTime.format(context)).join('-');
    return slot;
  }
}