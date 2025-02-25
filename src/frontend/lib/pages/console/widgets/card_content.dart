import 'package:flutter/material.dart';

class CardContent extends StatelessWidget {
  final Widget icon;
  final Widget body;
  final Widget price;

  const CardContent({
    super.key,
    required this.body,
    required this.price,
    this.icon = const Icon(Icons.cut),
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: icon
        ),
        Expanded(
          flex: 3,
          child: body,
        ),
        Expanded(
          flex: 1,
          child: price
        )
      ],
    );
  }
}
