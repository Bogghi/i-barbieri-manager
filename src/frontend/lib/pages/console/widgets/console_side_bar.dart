import 'package:flutter/material.dart';

class ConsoleSideBar extends StatelessWidget {
  const ConsoleSideBar({super.key});

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
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
              ),
              onPressed: () {},
              child: SizedBox(
                height: 40,
                child: Icon(
                  Icons.settings_outlined,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}