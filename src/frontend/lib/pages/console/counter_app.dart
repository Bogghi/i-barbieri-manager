import "package:flutter/material.dart";

import "package:frontend/pages/console/widgets/sidebar.dart";

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Row(
        children: [
          // Left Side - AppBar
          Sidebar(),
          // Right Side - Playground
          Expanded(
            child: Placeholder(),
          ),
        ],
      ),
    );
  }
}
