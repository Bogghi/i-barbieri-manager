import 'package:flutter/material.dart';

class ConsoleSideBar extends StatelessWidget {
  const ConsoleSideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: double.infinity,
      color: Theme.of(context).colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const SizedBox(
                height: 40,
                child: Icon(Icons.euro_symbol_outlined)
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              child: const SizedBox(
                height: 40,
                child: Icon(Icons.settings_outlined),
              ),
            ),
          ],
        ),
      ),
    );
  }
}