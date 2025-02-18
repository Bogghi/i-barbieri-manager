import 'package:flutter/material.dart';
import 'package:frontend/pages/console/widgets/sidebar_button.dart';

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
            SidebarButton(
              active: true,
              icon: const Icon(Icons.euro_symbol_outlined),
              onPressed: () {},
            ),
            const SizedBox(height: 10),
            SidebarButton(
              icon: const Icon(Icons.settings_outlined),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}