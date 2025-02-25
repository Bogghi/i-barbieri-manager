import 'package:flutter/material.dart';
import 'package:frontend/meta/utilities.dart';
import 'package:frontend/models/barber_store_service.dart';
import 'package:frontend/pages/console/widgets/card_content.dart';
import 'package:frontend/pages/console/widgets/console_top_navbar.dart';

import 'package:frontend/providers/barber_store_services_provider.dart';
import 'package:provider/provider.dart';

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          const Expanded(
            flex: 1,
            child: ConsoleTopNavbar()
          ),
          Expanded(
            flex: 15,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                spacing: 10,
                children: [
                  Expanded(
                    flex: 3,
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // Number of columns
                        crossAxisSpacing: 10, // Horizontal spacing between cards
                        mainAxisSpacing: 10, // Vertical spacing between cards
                        childAspectRatio: 80 / 20, // Width to height ratio
                      ),
                      itemCount: context.watch<BarberStoreServicesProvider>().getServices().length, // Number of cards
                      itemBuilder: (context, index) {
                        BarberStoreService service = context.watch<BarberStoreServicesProvider>().getServices()[index];
                        return Card(
                          child: CardContent(
                            body: Text(service.serviceName),
                            price: Text(Utilities.readableEurVal(service.servicePrice)),
                          ),
                        );
                      },
                    ),
                  ),
                  const Expanded(
                    flex: 1,
                    child: Placeholder()
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
