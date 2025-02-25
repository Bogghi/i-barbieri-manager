import 'package:flutter/material.dart';
import 'package:frontend/pages/console/widgets/console_top_navbar.dart';

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: ConsoleTopNavbar()
          ),
          Expanded(
            flex: 15,
            child: Placeholder(),
          )
        ],
      ),
    );
  }
}
