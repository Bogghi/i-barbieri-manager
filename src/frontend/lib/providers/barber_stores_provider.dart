import 'package:flutter/material.dart';
import 'package:frontend/api/api_client.dart';
import 'package:frontend/models/barber_store.dart';

class BarberStoresProvider extends ChangeNotifier {
  List<BarberStore> _stores = [];

  BarberStoresProvider();

  void addStore(BarberStore store) {
    _stores.add(store);
    notifyListeners();
  }

  List<BarberStore> getStores() {
    return _stores;
  }

  Future<void> fetch() async {
    List<BarberStore> stores = await ApiClient.getBarberStore();

    for (var store in stores) {
      _stores.add(store);
    }

    notifyListeners();
  }
}