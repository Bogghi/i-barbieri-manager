import 'package:flutter/material.dart';
import 'package:frontend/api/api_client.dart';
import 'package:frontend/models/barber_store_service.dart';

enum CounterSegment {counter, history, schedule}

class ConsoleProvider extends ChangeNotifier {

  CounterSegment selected = CounterSegment.counter;
  Map<int, Map<String, dynamic>> cart = {};

  ConsoleProvider();

  void setSelected(CounterSegment segment) {
    selected = segment;
    notifyListeners();
  }

  void updateCart(BarberStoreService service, int quantity) {

    if(cart.containsKey(service.barberServiceId)) {
      cart[service.barberServiceId]!["quantity"] += quantity;

      if(cart[service.barberServiceId]!["quantity"] == 0) {
        cart.remove(service.barberServiceId);
      }

    }
    else {
      cart[service.barberServiceId] = {
        "service": service,
        "quantity": quantity
      };
    }

    notifyListeners();
  }

  Future<bool> addOrder(String paymentMethod) async {
    Map<String, dynamic> orderData = {
      "services": cart.values.map((e) => {
        "barber_service_id": e["service"].barberServiceId,
        "quantity": e["quantity"]
      }).toList(),
      "payment_method": paymentMethod
    };

    Map<String, dynamic> response = await ApiClient.addOrder(orderData);

    return response["result"] == "OK";
  }
}