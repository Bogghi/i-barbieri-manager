import 'package:flutter/material.dart';

class Panel extends StatelessWidget {
  final Widget child;
  final double width;

  const Panel({
    super.key,
    required this.child,
    this.width = double.infinity
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(30)
      ),
      width: width,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: child,
      ),
    );
  }
}
