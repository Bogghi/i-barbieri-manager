import 'package:flutter/material.dart';

class PanelTitle extends StatelessWidget {
  final String label;

  const PanelTitle({
    super.key,
    required this.label
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        fontSize: 18,
        fontWeight: FontWeight.bold
      ),
    );
  }
}
