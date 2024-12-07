import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:frontend/pages/shared/AppAppBar.dart';

class ConfirmReservationApp extends StatelessWidget {
  const ConfirmReservationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(FontAwesomeIcons.check, size: 70, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 15),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                "Il tuo appuntamento è stato preso in carico, appena possibile ti verra inviata la conferma",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}
