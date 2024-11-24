import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        title: const Text("I Barbieri Lissone"),
        centerTitle: false,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: (){}, icon: const FaIcon(FontAwesomeIcons.circleUser))
        ],
      ),
      body: const Placeholder()
    );
  }
}
