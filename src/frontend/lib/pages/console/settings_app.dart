import "package:flutter/material.dart";

import "package:frontend/pages/console/widgets/sidebar.dart";

class SettingsApp extends StatelessWidget {
  const SettingsApp({super.key});

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
