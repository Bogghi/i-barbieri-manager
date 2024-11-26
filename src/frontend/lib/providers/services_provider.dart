import 'package:flutter/material.dart';

class ServicesProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _services = [
    {"id": 0,"service": "Taglio capelli", "price": "20€", "duration": "30 min"},
    {"id": 1,"service": "Barba disegnata", "price": "20€", "duration": "30 min"},
    {"id": 2,"service": "Taglio Under 10", "price": "20€", "duration": "30 min"},
    {"id": 3,"service": "Rasatura capelli", "price": "20€", "duration": "30 min"},
    {"id": 4,"service": "Barba a macchinetta", "price": "20€", "duration": "30 min"},
    {"id": 5,"service": "Taglio + barba disegnata", "price": "20€", "duration": "1h"},
    {"id": 6,"service": "Rasatura totale B+C", "price": "20€", "duration": "1h"},
  ];

  void setServices(List<Map<String, dynamic>> services) {
    _services = services;
  }

  List<Map<String, dynamic>> getServices() {
    return _services;
  }
}