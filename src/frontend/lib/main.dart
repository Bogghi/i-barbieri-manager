import 'package:flutter/material.dart';
import 'package:fronend/providers/reservation_provider.dart';
import 'package:provider/provider.dart';

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
        initialRoute: '/',
        routes: {
          '/': (context) => const Center(child: Text("this is the index page"),),
          '/reservation': (context) => const Center(child: Text('I want to make a reservation'))
        },
      )
    );
  }
}
