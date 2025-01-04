import 'package:flutter/material.dart';
import 'package:frontend/api/api_client.dart';
import 'package:frontend/models/slot.dart';

class SlotProvider extends ChangeNotifier {
  List<Slot> _slots = [];

  Future<void> fetch(int barberStoreId, DateTime day, int barberId, int serviceId) async {
    List<Slot> data = await ApiClient.getSlots(barberStoreId, day, barberId, serviceId);

    _slots = data;

    notifyListeners();
  }

  List<Slot> getSlots() {
    return _slots;
  }
}