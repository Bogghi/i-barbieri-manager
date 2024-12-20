import 'package:flutter/material.dart';
import 'package:frontend/models/barber_store_service.dart';
import 'package:provider/provider.dart';

import 'package:frontend/pages/reservation/widgets/button.dart';
import 'package:frontend/pages/reservation/widgets/panel_label.dart';
import 'package:frontend/pages/reservation/widgets/panel_title.dart';
import 'package:frontend/providers/barbers_provider.dart';
import 'package:frontend/providers/reservation_provider.dart';
import 'package:frontend/providers/barber_store_services_provider.dart';
import 'package:frontend/pages/shared/AppAppBar.dart';
import 'package:frontend/models/barber.dart';

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
      appBar: const AppAppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(18, 10, 18, 10),
        child: ListView(
          children: [
            serviceContent(),
            servicePicker(),
            barberContent(),
            barberPicker(),
            dayContent(),
            slotContent(),
            slotPicker(),
            confirmationButton()
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
      var serviceMap = context.watch<BarberStoreServicesProvider>().getServices().firstWhere((serviceMap) {
        return serviceMap.barberServiceId == context.watch<ReservationProvider>().getServiceSelected();
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
            PanelLabel(label: '${serviceMap.serviceName} ${serviceMap.formattedPrice()}'),
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
            final services = context.watch<BarberStoreServicesProvider>().getServices();
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
                BarberStoreService service = services[index];
                return Button(
                  onPressed: () {
                    context.read<ReservationProvider>().setService(service.barberServiceId);
                    setState(() {
                      step = 1;
                    });
                  },
                  selected: index == context.watch<ReservationProvider>().getServiceSelected(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        service.serviceName,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                          service.formattedPrice(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          )
                      ),
                      Text(
                        service.formattedDuration(),
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
        return barber.barberId == barberSelected;
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
            PanelLabel(label: barberMap.name)
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
                Barber barber = barbers[index];
                return Button(
                  onPressed: () {
                    context.read<ReservationProvider>().setBarber(
                        barber.barberId
                    );
                    setState(() {
                      step = 2;
                    });
                  },
                  selected: barber.barberId == context.watch<ReservationProvider>().getBarberSelected(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(barber.imgUrl),
                        radius: 30,
                      ),
                      const Spacer(),
                      Text(
                        barber.name,
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
    String dateLabel = "";

    if(context.watch<ReservationProvider>().getDate() != null) {
      dateLabel = context.watch<ReservationProvider>().getDate().toString().substring(0, 10);
    }

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
              child: PanelLabel(label: dateLabel),
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
          onTap: () {
            setState(() {
              step = 3;
            });
          },
          child: Row(
            children: [
              const PanelTitle(label: "Orario"),
              const Spacer(),
              Visibility(
                visible: step > 3,
                child: PanelLabel(label: context.watch<ReservationProvider>().getSlot(context))
              ),
            ],
          ),
        ),
      )
    );
  }
  Widget slotPicker() {
    return Visibility(
      visible: step == 3,
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 8,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.8,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15
          ),
          itemBuilder: (context, index) {
            return Button(
              onPressed: () {
                context.read<ReservationProvider>().setSlot([
                  const TimeOfDay(hour: 9, minute: 30), const TimeOfDay(hour: 10, minute: 0)
                ]);
                setState(() {
                  step = 4;
                });
              },
              selected: index == context.watch<ReservationProvider>().getServiceSelected(),
              child: Text("9:30 - 10:00"),
            );
          },
        ),
      ),
    );
  }

  Widget confirmationButton() {
    return Visibility(
      visible: step == 4,
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
            )
          ),
          onPressed: (){
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Ultimo Step", style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold
                          )),
                          const Text("Per poterti comunicare la conferma dell'appuntamento ti chiediamo di lasciarci il tuo numero di telefono",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18)
                          ),
                          const TextField(
                            decoration: InputDecoration(
                              labelText: "Numero"
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context).colorScheme.primary,
                                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)
                                  ),
                                ),
                                onPressed: (){
                                  Navigator.pushNamed(context, '/confirmReservation');
                                },
                                child: const Text(
                                  'Salva',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25,)
                                )
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
            );
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Conferma", style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            )),
          ),
        ),
      )
    );
  }
}