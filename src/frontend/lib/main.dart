import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:frontend/theme/theme.dart';
import 'package:frontend/theme/util.dart';
import 'package:frontend/providers/reservation_provider.dart';
import 'package:frontend/pages/reservation/reservation_app.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    TextTheme textTheme = createTextTheme(context, "Abel", "ABeeZee");
    MaterialTheme theme = MaterialTheme(textTheme);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ReservationProvider()
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Barber manager',
        theme: brightness == Brightness.light ? theme.light() : theme.dark(),
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
