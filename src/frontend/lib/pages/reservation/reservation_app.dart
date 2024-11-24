import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/pages/reservation/widgets/button.dart';
import 'package:frontend/providers/reservation_provider.dart';
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
    final List<Map<String, dynamic>> services = [
      {"service": "Taglio capelli", "price": "20€", "duration": "30 min"},
      {"service": "Barba disegnata", "price": "20€", "duration": "30 min"},
      {"service": "Taglio Under 10", "price": "20€", "duration": "30 min"},
      {"service": "Rasatura capelli", "price": "20€", "duration": "30 min"},
      {"service": "Barba a macchinetta", "price": "20€", "duration": "30 min"},
      {"service": "Taglio + barba disegnata", "price": "20€", "duration": "1h"},
      {"service": "Rasatura totale B+C", "price": "20€", "duration": "1h"},
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: FaIcon(FontAwesomeIcons.scissors),
            ),
            Text("I Barbieri Lissone")
          ],
        ),
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
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              serviceContent(),
              const SizedBox(height: 15.0),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    const double itemHeight = 100; // Example height of the content
                    final double itemWidth = constraints.maxWidth / 2 - 15; // Example width of the content
                    final double aspectRatio = itemWidth / itemHeight;

                    return GridView.builder(
                      shrinkWrap: true,
                      itemCount: services.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        childAspectRatio: aspectRatio,
                      ),
                      itemBuilder: (context, index) => Button(
                        onPressed: () {
                          context.read<ReservationProvider>().setService(index);
                        },
                        selected: index == context.watch<ReservationProvider>().getServiceSelected(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              services[index]['service'],
                              textAlign: TextAlign.center,
                            ),
                            Text(
                                services[index]['price'],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                )
                            ),
                            Text(
                              services[index]['duration'],
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget serviceContent() {
    return Panel(
      child: Align(
        child: Text(
          "Servizi",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}