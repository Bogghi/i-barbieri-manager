import 'package:flutter/material.dart';

class ReservationProvider extends ChangeNotifier {
  int _service = -1;
  int ?_barber = null;
  DateTime ?_date = null;
  List<TimeOfDay> _slot = [];

  ReservationProvider();

  int getServiceSelected() {
    return _service;
  }
  void setService(int service) {
    _service = service;
    notifyListeners();
  }

  int? getBarberSelected() {
    return _barber;
  }
  void setBarber(int barber) {
    _barber = barber;
    notifyListeners();
  }

  DateTime? getDate() {
    return _date;
  }
  void setDate(DateTime date){
    _date = date;
  }

  void setSlot(List<TimeOfDay> slot) {
    _slot = slot;
  }
  String getSlot(BuildContext context) {
    var slot = _slot.map((slotTime) => slotTime.format(context)).join('-');
    return slot;
  }
}