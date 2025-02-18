import "package:flutter/material.dart";

import "package:frontend/pages/console/widgets/console_side_bar.dart";

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Row(
        children: [
          // Left Side - AppBar
          ConsoleSideBar(),
          // Right Side - Playground
          Expanded(
            child: Placeholder(),
          ),
        ],
      ),
    );
  }
}
