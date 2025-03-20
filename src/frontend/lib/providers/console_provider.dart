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
      "items": [],
      "amount": 0,
      "payment_method": paymentMethod
    };

    for (var item in cart.values) {
      orderData["amount"] += item["service"].servicePrice * item["quantity"];
      orderData["items"].add({
        "id": item["service"].barberServiceId,
        "quantity": item["quantity"]
      });
    }

    Map<String, dynamic> response = await ApiClient.addOrder(12, orderData);

    return response["result"] == "OK";
  }
}