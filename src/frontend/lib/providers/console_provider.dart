import 'package:flutter/material.dart';

enum CounterSegment {counter, history, schedule}
class ConsoleProvider extends ChangeNotifier {
  CounterSegment selected = CounterSegment.counter;
  ConsoleProvider();

  void setSelected(CounterSegment segment) {
    selected = segment;
    notifyListeners();
  }
}