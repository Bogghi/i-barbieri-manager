import "package:flutter/material.dart";

import "package:frontend/pages/console/widgets/console_side_bar.dart";

class ConsoleApp extends StatelessWidget {
  const ConsoleApp({super.key});

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
