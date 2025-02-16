import "package:flutter/material.dart";

class ConsoleApp extends StatelessWidget {
  const ConsoleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left Side - AppBar
          Container(
            width: 80,
            height: double.infinity,
            color: Theme.of(context).colorScheme.secondary,
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Column(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.countertops_outlined,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.settings_outlined,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          // Right Side - Playground
          const Expanded(
            child: Placeholder(),
          ),
        ],
      ),
    );
  }
}
