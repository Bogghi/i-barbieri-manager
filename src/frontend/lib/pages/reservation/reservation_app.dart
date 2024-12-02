import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/pages/reservation/widgets/button.dart';
import 'package:frontend/pages/reservation/widgets/panel_label.dart';
import 'package:frontend/pages/reservation/widgets/panel_title.dart';

import 'package:provider/provider.dart';
import 'package:frontend/providers/settings_provider.dart';
import 'package:frontend/providers/barbers_provider.dart';
import 'package:frontend/providers/reservation_provider.dart';
import 'package:frontend/providers/services_provider.dart';

import 'widgets/panel.dart';

class ReservationApp extends StatefulWidget {
  const ReservationApp({super.key});

  @override
  State<ReservationApp> createState() => _ReservationAppState();
}

class _ReservationAppState extends State<ReservationApp> {
  int step = 0;

  @override
  Widget build(BuildContext context) {
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
        padding: const EdgeInsets.fromLTRB(18, 10, 18, 10),
        child: ListView(
          children: [
            serviceContent(),
            servicePicker(),
            barberContent(),
            barberPicker(),
            dayContent(),
            slotContent()
          ],
        ),
      ),
    );
  }

  Widget serviceContent() {
    Widget service = const Panel(
      child: Align(
        child: PanelTitle(label: "Servizi",),
      ),
    );

    if(step > 0) {
      var serviceMap = context.watch<ServicesProvider>().getServices().firstWhere((serviceMap) {
        return serviceMap['id'] == context.watch<ReservationProvider>().getServiceSelected();
      });

      service = Panel(
        onTap: () {
          setState(() {
            step = 0;
          });
        },
        child: Row(
          children: [
            const PanelTitle(label: "Servizio"),
            const Spacer(),
            PanelLabel(label: '${serviceMap['service']} ${serviceMap['price']}'),
          ],
        ),
      );
    }

    return service;
  }
  Widget servicePicker() {
    return Visibility(
      visible: step == 0,
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final services = context.watch<ServicesProvider>().getServices();
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
              itemBuilder: (context, index) {
                Map<String, dynamic>? service = services[index];
                return Button(
                  onPressed: () {
                    context.read<ReservationProvider>().setService(
                        services[index]['id']
                    );
                    setState(() {
                      step = 1;
                    });
                  },
                  selected: index == context.watch<ReservationProvider>().getServiceSelected(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        service['service'],
                        textAlign: TextAlign.center,
                      ),
                      Text(
                          service['price'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          )
                      ),
                      Text(
                        service['duration'],
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget barberContent() {
    Widget content = const Panel(
      child: Align(
        child: PanelTitle(label: "Barbiere"),
      ),
    );

    var barberSelected = context.watch<ReservationProvider>().getBarberSelected();
    if(step >= 2 && barberSelected != null) {
      var barberMap = context.watch<BarbersProvider>().getBarbers().firstWhere((barber) {
        return barber['id'] == barberSelected;
      });

      content = Panel(
        onTap: () {
          setState(() {
            step = 1;
          });
        },
        child: Row(
          children: [
            Text(
              "Barbiere",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
            const Spacer(),
            PanelLabel(label: barberMap['name'])
          ],
        ),
      );
    }

    return Visibility(
      visible: step >= 1,
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: content,
      ),
    );
  }
  Widget barberPicker() {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Visibility(
        visible: step == 1,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final barbers = context.watch<BarbersProvider>().getBarbers();
            const double itemHeight = 100; // Example height of the content
            final double itemWidth = constraints.maxWidth / 2 - 15; // Example width of the content
            final double aspectRatio = itemWidth / itemHeight;

            return GridView.builder(
              shrinkWrap: true,
              itemCount: barbers.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: aspectRatio,
              ),
              itemBuilder: (context, index) {
                Map<String, dynamic> barber = barbers[index];
                return Button(
                  onPressed: () {
                    context.read<ReservationProvider>().setBarber(
                        barber['id']
                    );
                    setState(() {
                      step = 2;
                    });
                  },
                  selected: barber['id'] == context.watch<ReservationProvider>().getBarberSelected(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(barber['img-url']),
                        radius: 30,
                      ),
                      const Spacer(),
                      Text(
                        barber['name'],
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            );
          },
        )
      ),
    );
  }

  Widget dayContent() {

    return Visibility(
      visible: step >= 2,
      child: Panel(
        onTap: () {
          if(step > 2){
            setState(() {
              step = 2;
            });
          }
        },
        child: Row(
          children: [
            const PanelTitle(label: "Giorno"),
            const Spacer(),
            Visibility(
              visible: step == 2,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(100, 25),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap
                ),
                onPressed: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(const Duration(days: 0)),
                    lastDate: DateTime(2100),
                  );
                  if(pickedDate != null) {
                    context.read<ReservationProvider>().setDate(pickedDate);
                    setState(() {
                      step = 3;
                    });
                  }
                },
                child: const Text("Seleaizona giorno")
              ),
            ),
            Visibility(
              visible: step >= 3,
              child: PanelLabel(label: context.watch<ReservationProvider>().getDate().toString().substring(0, 10)),
            )
          ],
        ),
      ),
    );
  }

  Widget slotContent() {
    return Visibility(
      visible: step >= 3,
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Panel(
          child: Column(
            children: [
              PanelTitle(label: "Orario"),
            ],
          ),
        ),
      )
    );
  }
}