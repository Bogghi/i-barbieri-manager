import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:frontend/pages/shared/primary_button.dart';
import 'package:frontend/providers/console_provider.dart';

class PaymentsBottomSheet extends StatelessWidget {
  const PaymentsBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 10,
            children: [
              const Text(
                'Seleziona il metodo di pagamento',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                spacing: 10,
                children: [
                  Expanded(
                    flex: 1,
                    child: PrimaryButton(
                      label: 'Carta',
                      onPresssed: (){
                        handleAddOrder(context, "Carta");
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: PrimaryButton(
                      label: 'Contante',
                      onPresssed: (){
                        handleAddOrder(context, "Contante");
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void handleAddOrder(BuildContext context, String paymentMethod) async {
    final bool result = await context.read<ConsoleProvider>().addOrder(paymentMethod);
    if(result) {
      print("order added");
    }
  }
}
