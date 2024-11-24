import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
          IconButton(onPressed: (){}, icon: const FaIcon(FontAwesomeIcons.circleUser))
        ],
      ),
      body: const Column(
        children: [
          Panel(child: Text("hello"),)
        ],
      ),
    );
  }
}
