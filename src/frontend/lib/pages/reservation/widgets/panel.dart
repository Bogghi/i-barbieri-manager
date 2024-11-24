import 'package:flutter/material.dart';

class Panel extends StatelessWidget {
  final Widget child;
  final double width;
  final double ?height;

  const Panel({
    super.key,
    required this.child,
    this.width = double.infinity,
    this.height
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(15)
      ),
      width: width,
      height: height,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: child,
      ),
    );
  }
}
