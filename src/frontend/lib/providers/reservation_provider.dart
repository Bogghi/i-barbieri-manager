import 'package:flutter/material.dart';

import 'package:frontend/api/api_client.dart';
import 'package:frontend/models/slot.dart';

class ReservationProvider extends ChangeNotifier {
  int _reservationStep = 0;
  int _service = -1;
  int ?_barber;
  DateTime ?_date;
  Slot ?_slot;
  String ?_number;

  int ?_reservationId;

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

  void setSlot(Slot slot) {
    _slot = slot;
    _reservationStep = 4;
    notifyListeners();
  }
  Slot? getSlot() => _slot;

  void setNumber(String number) {
    _number = number;
    notifyListeners();
  }
  String? getNumber() => _number;

  Future<int?> book() async {
    int? reservationId = await ApiClient.bookAppointment(12, _date!, _barber!, _service, _slot!.startTime, _slot!.endTime, _number!);

    return reservationId;
  }
  int? getReservationId() => _reservationId;
}