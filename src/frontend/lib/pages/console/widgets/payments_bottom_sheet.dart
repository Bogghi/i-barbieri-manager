import 'package:flutter/material.dart';
import 'package:frontend/pages/shared/primary_button.dart';

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

                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: PrimaryButton(
                      label: 'Contante',
                      onPresssed: (){
                        
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
}
