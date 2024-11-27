import 'package:flutter/material.dart';

class PanelLabel extends StatelessWidget {
  final String label;

  const PanelLabel({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.tertiary,
            ),
            BoxShadow(
              color: Theme.of(context).colorScheme.secondaryContainer,
              spreadRadius: -1.0,
              blurRadius: 3.0,
            ),
          ],
          borderRadius: BorderRadius.circular(10)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Text(
            label,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondaryContainer,
              fontSize: 18,
            )
        ),
      ),
    );
  }
}
