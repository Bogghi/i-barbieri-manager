import "package:flutter/material.dart";

class ConsoleApp extends StatelessWidget {
  const ConsoleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left Side - AppBar
          AppBar(
            title: Text('AppBar'),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          // Right Side - Playground
          Expanded(
            child: Container(
              child: Center(
                child: Text(
                  'Playground',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
