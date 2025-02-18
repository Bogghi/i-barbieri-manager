import 'package:flutter/material.dart';
import 'package:frontend/meta/routes.dart';
import 'package:frontend/models/barber_store_service.dart';
import 'package:frontend/providers/slot_provider.dart';
import 'package:provider/provider.dart';

import 'package:frontend/pages/shared/button.dart';
import 'package:frontend/pages/reservation/widgets/panel_label.dart';
import 'package:frontend/pages/reservation/widgets/panel_title.dart';
import 'package:frontend/providers/barbers_provider.dart';
import 'package:frontend/providers/reservation_provider.dart';
import 'package:frontend/providers/barber_store_services_provider.dart';
import 'package:frontend/pages/shared/AppAppBar.dart';
import 'package:frontend/models/barber.dart';
import 'package:frontend/models/slot.dart';

import 'widgets/panel.dart';

class ReservationApp extends StatelessWidget {
  late BuildContext context;
  final TextEditingController numberController = TextEditingController();

  ReservationApp({super.key});

  @override
  Widget build(BuildContext context) {
    this.context = context;
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

    if(context.watch<ReservationProvider>().getStep() > 0) {
      var serviceMap = context.watch<BarberStoreServicesProvider>().getServices().firstWhere((serviceMap) {
        return serviceMap.barberServiceId == context.watch<ReservationProvider>().getServiceSelected();
      });

      service = Panel(
        onTap: () {
          context.read<ReservationProvider>().setStep(0);
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
      visible: context.watch<ReservationProvider>().getStep() == 0,
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final services = this.context.watch<BarberStoreServicesProvider>().getServices();
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
                BarberStoreService? service = services[index];
                return Button(
                  onPressed: () {
                    this.context.read<ReservationProvider>().setService(service.barberServiceId);
                  },
                  selected: index == this.context.watch<ReservationProvider>().getServiceSelected(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        service!.serviceName,
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
    if(context.watch<ReservationProvider>().getStep() >= 2 && barberSelected != null) {
      var barberMap = context.watch<BarbersProvider>().getBarbers().firstWhere((barber) {
        return barber.barberId == barberSelected;
      });

      content = Panel(
        onTap: () {
          context.read<ReservationProvider>().setStep(1);
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
      visible: context.watch<ReservationProvider>().getStep() >= 1,
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
        visible: context.watch<ReservationProvider>().getStep() == 1,
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
                    this.context.read<ReservationProvider>().setBarber(
                        barber.barberId
                    );
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
      visible: context.watch<ReservationProvider>().getStep() >= 2,
      child: Panel(
        onTap: () {
          context.read<ReservationProvider>().setStep(2);
        },
        child: Row(
          children: [
            const PanelTitle(label: "Giorno"),
            const Spacer(),
            Visibility(
              visible: context.watch<ReservationProvider>().getStep() == 2,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(100, 25),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap
                ),
                onPressed: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(const Duration(days: 0)),
                    lastDate: DateTime(2100),
                  );

                  if (pickedDate != null && context.mounted) {
                    context.read<ReservationProvider>().setDate(pickedDate);
                    var barberId = context.read<ReservationProvider>().getBarberSelected() ?? 0;
                    var serviceId = context.read<ReservationProvider>().getServiceSelected();
                    context.read<SlotProvider>().fetch(12, pickedDate, barberId, serviceId);
                  }
                },
                child: const Text("Seleaizona giorno")
              ),
            ),
            Visibility(
              visible: context.watch<ReservationProvider>().getStep() >= 3,
              child: PanelLabel(label: dateLabel),
            )
          ],
        ),
      ),
    );
  }

  Widget slotContent() {
    String label = "";

    if(context.watch<ReservationProvider>().getSlot() != null) {
      label = context.watch<ReservationProvider>().getSlot()!.getFormattedString();
    }

    return Visibility(
      visible: context.watch<ReservationProvider>().getStep() >= 3,
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Panel(
          onTap: () {
            context.read<ReservationProvider>().setStep(3);
          },
          child: Row(
            children: [
              const PanelTitle(label: "Orario"),
              const Spacer(),
              Visibility(
                visible: context.watch<ReservationProvider>().getStep() > 3,
                child: PanelLabel(label: label)
              ),
            ],
          ),
        ),
      )
    );
  }
  Widget slotPicker() {
    Widget picker;

    if(context.watch<SlotProvider>().noSlot()) {
      picker = const Center(child: Text("Prenotazioni non disponibili"));
    } else {
      picker = GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: context.watch<SlotProvider>().getSlots().length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.8,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15
        ),
        itemBuilder: (context, index) {
          return Button(
            onPressed: () {
              Slot slot = this.context.read<SlotProvider>().getSlots()[index];
              this.context.read<ReservationProvider>().setSlot(slot);
            },
            selected: index == this.context.watch<ReservationProvider>().getServiceSelected(),
            child: Text(this.context.watch<SlotProvider>().getSlots()[index].getFormattedString()),
          );
        },
      );
    }

    return Visibility(
      visible: context.watch<ReservationProvider>().getStep() == 3,
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: picker,
      ),
    );
  }

  Widget confirmationButton() {
    return Visibility(
      visible: context.watch<ReservationProvider>().getStep() == 4,
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
              builder: (context) {
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
                          TextField(
                            controller: numberController,
                            decoration: const InputDecoration(
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
                                  this.context.read<ReservationProvider>().setNumber(numberController.text);
                                  handleBooking();
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
  void handleBooking() async {
    int? reservationId = await context.read<ReservationProvider>().book();
    if(context.mounted && reservationId != null) {
      Navigator.pushNamed(context, Routes.confirmReservation);
    }
  }
}