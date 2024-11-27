import 'package:flutter/material.dart';

class BarbersProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _barbers = [
    {
      'id': 0,
      'name': 'Gianny',
      'img-url': 'https://images.unsplash.com/photo-1543965170-4c01a586684e?q=80&w=2349&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    },
    {
      'id': 1,
      'name': 'Valentina',
      'img-url': 'https://plus.unsplash.com/premium_photo-1705018501151-4045c97658a3?q=80&w=2340&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    }
  ];

  BarbersProvider();

  void setBarber(Map<String, dynamic> barber) {
    _barbers.add(barber);
  }

  List<Map<String, dynamic>> getBarbers() {
    return _barbers;
  }
}