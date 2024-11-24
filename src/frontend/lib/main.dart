import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:frontend/providers/reservation_provider.dart';

import 'package:frontend/pages/reservation/reservation_app.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ReservationProvider()
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Barber manager',
        // Temporary set to reservation to work on that specific ui section
        initialRoute: '/reservation',
        routes: {
          '/': (context) => const Center(child: Text("this is the index page"),),
          '/reservation': (context) => const ReservationApp()
        },
      )
    );
  }
}
