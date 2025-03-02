import 'package:flutter/material.dart';

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
          child: Row(
            spacing: 10,
            children: [
              ElevatedButton(onPressed: (){}, child: Text('Carta')),
              ElevatedButton(onPressed: (){}, child: Text('Contante')),
            ],
          ),
        ),
      ),
    );
  }
}
