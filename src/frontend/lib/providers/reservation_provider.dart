import 'package:flutter/material.dart';

class ReservationProvider extends ChangeNotifier {
  int service;

  ReservationProvider({
    this.service = 0,
  });
}