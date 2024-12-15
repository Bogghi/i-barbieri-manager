import 'package:flutter/material.dart';
import 'package:frontend/api/api_client.dart';
import 'package:frontend/models/barber_store_service.dart';

class BarberStoreServicesProvider extends ChangeNotifier {
  List<BarberStoreService> _services = [];

  void setServices(List<BarberStoreService> services) {
    _services = services;
  }

  List<BarberStoreService> getServices() {
    return _services;
  }

  Future<void> fetch(int barberStoreId) async {
    final List<BarberStoreService> data = await ApiClient.getServices(barberStoreId);

    _services = data;
  }
}