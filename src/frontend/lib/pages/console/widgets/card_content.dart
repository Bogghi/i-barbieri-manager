import 'package:flutter/material.dart';

class CardContent extends StatelessWidget {
  final Widget icon;
  final Widget body;
  final Widget price;
  final Widget? cartCounter;

  const CardContent({
    super.key,
    required this.body,
    required this.price,
    this.icon = const Icon(Icons.cut),
    this.cartCounter
  });

  @override
  Widget build(BuildContext context) {

    List<Widget> rowChildrens = [
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
      ),
    ];

    if(cartCounter != null) {
      rowChildrens.add(Padding(
        padding: const EdgeInsets.only(right: 8),
        child: cartCounter!,
      ));
    }

    return Row(
      children: rowChildrens,
    );
  }
}
