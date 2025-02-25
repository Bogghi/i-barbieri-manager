import 'package:flutter/material.dart';
import 'package:frontend/meta/utilities.dart';
import 'package:frontend/models/barber_store_service.dart';
import 'package:frontend/pages/console/widgets/card_content.dart';
import 'package:frontend/pages/console/widgets/console_top_navbar.dart';

import 'package:frontend/providers/barber_store_services_provider.dart';
import 'package:frontend/providers/console_provider.dart';
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
                        childAspectRatio: 80 / 10, // Width to height ratio
                      ),
                      itemCount: context.watch<BarberStoreServicesProvider>().getServices().length, // Number of cards
                      itemBuilder: (context, index) {
                        BarberStoreService service = context.watch<BarberStoreServicesProvider>().getServices()[index];
                        Widget? cartCounter;

                        if(context.watch<ConsoleProvider>().cart.containsKey(service.barberServiceId)) {
                          String quantity = "x ${context.watch<ConsoleProvider>()
                              .cart[service.barberServiceId]!["quantity"]}";

                          cartCounter = Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: const BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              child: Text(
                                quantity,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onPrimary
                                ),
                              ),
                            )
                          );
                        }

                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            side: BorderSide(color: Theme.of(context).colorScheme.primary),
                          ),
                          child: InkWell(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            onTap: () {
                              context.read<ConsoleProvider>().addToCart(service, 1);
                            },
                            child: CardContent(
                              body: Text(
                                service.serviceName,
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              price: Text(
                                Utilities.readableEurVal(service.servicePrice),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              cartCounter: cartCounter,
                            ),
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
