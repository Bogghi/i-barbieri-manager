import "package:flutter/material.dart";
import "package:frontend/pages/console/widgets/counter_app.dart";

import "package:frontend/pages/console/widgets/sidebar.dart";
import "package:frontend/meta/routes.dart";

class ConsoleApp extends StatelessWidget {
  const ConsoleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final Widget main;

        switch(ModalRoute.of(context)?.settings.name) {
          case Routes.counter:
            main = CounterApp();
            break;
          default: main = const Placeholder();
        }

        return Scaffold(
          body: Row(
            children: [
              // Left Side - AppBar
              const Sidebar(),
              // Right Side - Playground
              main
            ],
          ),
        );
      },
    );
  }
}
