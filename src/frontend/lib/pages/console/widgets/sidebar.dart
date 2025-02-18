import 'package:flutter/material.dart';
import 'package:frontend/meta/routes.dart';
import 'package:frontend/pages/console/widgets/sidebar_button.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    print(ModalRoute.of(context)?.settings.name);
    return Container(
      width: 80,
      height: double.infinity,
      color: Theme.of(context).colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Column(
          children: [
            SidebarButton(
              active: ModalRoute.of(context)?.settings.name == Routes.counter,
              icon: const Icon(Icons.euro_symbol_outlined),
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.counter);
              },
            ),
            const SizedBox(height: 10),
            SidebarButton(
              active: ModalRoute.of(context)?.settings.name == Routes.settings,
              icon: const Icon(Icons.settings_outlined),
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.settings);
              },
            )
          ],
        ),
      ),
    );
  }
}