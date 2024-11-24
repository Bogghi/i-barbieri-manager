import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:frontend/providers/settings_provider.dart';

import 'widgets/panel.dart';

class ReservationApp extends StatefulWidget {
  const ReservationApp({super.key});

  @override
  State<ReservationApp> createState() => _ReservationAppState();
}

class _ReservationAppState extends State<ReservationApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("I Barbieri Lissone"),
        centerTitle: false,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: (){
              context.read<SettingsProvider>().changeMode();
            },
            icon: Theme.of(context).colorScheme.brightness == Brightness.light ?
              const Icon(Icons.sunny) : const Icon(Icons.nightlight_outlined),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: FaIcon(FontAwesomeIcons.scissors),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Panel(
                child: Text(
                  "Servizi",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontSize: 18
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
