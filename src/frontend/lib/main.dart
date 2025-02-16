// main dependencies
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/theme/theme.dart';
import 'package:frontend/theme/util.dart';
// providers
import 'package:frontend/providers/reservation_provider.dart';
import 'package:frontend/providers/settings_provider.dart';
import 'package:frontend/providers/barber_store_services_provider.dart';
import 'package:frontend/providers/barbers_provider.dart';
import 'package:frontend/providers/barber_stores_provider.dart';
import 'package:frontend/providers/slot_provider.dart';
import 'package:frontend/providers/auth_provider.dart';
// pages
import 'package:frontend/pages/reservation/reservation_app.dart';
import 'package:frontend/pages/confirmReservation/confirm_reservation_app.dart';
import 'package:frontend/pages/login/login_app.dart';
import 'package:frontend/pages/console/console_app.dart';

void main() {
  runApp(const ProviderApp());
}

class ProviderApp extends StatelessWidget {
  const ProviderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ReservationProvider()),
        ChangeNotifierProvider(create: (context) => SettingsProvider()),
        ChangeNotifierProvider(create: (context) => BarberStoreServicesProvider()),
        ChangeNotifierProvider(create: (context) => BarbersProvider()),
        ChangeNotifierProvider(create: (context) => BarberStoresProvider()),
        ChangeNotifierProvider(create: (context) => SlotProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
      ],
      child: const App()
    );
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = context.watch<SettingsProvider>().getMode();

    TextTheme textTheme = createTextTheme(context, "Abel", "ABeeZee");
    MaterialTheme theme = MaterialTheme(textTheme);

    context.watch<AuthProvider>().fetchTokensFromStorage();
    String initialRoute = "/login";
    if(context.watch<AuthProvider>().oauthToken() != null) {
      initialRoute = "/console";
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Barber manager',
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      // Temporary set to reservation to work on that specific ui section
      initialRoute: initialRoute,
      routes: {
        '/console': (context) => ConsoleApp(),
        '/login': (context) => LoginApp(),
        '/reservation': (context) {
          context.read<BarberStoresProvider>().fetch();
          context.read<BarbersProvider>().fetch(12);
          context.read<BarberStoreServicesProvider>().fetch(12);
          return ReservationApp();
        },
        '/confirmReservation': (context) => const PopScope(canPop: false, child: ConfirmReservationApp()),
      },
    );
  }
}