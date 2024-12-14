import 'package:flutter/material.dart';
import 'package:frontend/api/api_client.dart';
import 'package:frontend/models/barber.dart';

class BarbersProvider extends ChangeNotifier {
  List<Barber> _barbers = [];

  BarbersProvider();

  void setBarber(Barber barber) {
    _barbers.add(barber);
    notifyListeners();
  }

  List<Barber> getBarbers() {
    return _barbers;
  }

  Future<void> fetch(int barberStoreId) async {
    List<Barber> data = await ApiClient.getBarbers(barberStoreId);

    _barbers = data;

    notifyListeners();
  }
}