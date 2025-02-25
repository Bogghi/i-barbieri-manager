import 'package:flutter/material.dart';

class Panel extends StatelessWidget {
  final Widget body;
  final Widget header;

  const Panel({
    super.key,
    required this.header,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            child: header,
          ),
          Container(
            child: body,
          )
        ]
      ),
    );
  }
}
