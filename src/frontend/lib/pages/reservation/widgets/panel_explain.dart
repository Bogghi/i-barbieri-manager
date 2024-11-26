import 'package:flutter/material.dart';

class PanelExplain extends StatelessWidget {
  final String label;

  const PanelExplain({
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
        fontWeight: FontWeight.w500
      ),
    );
  }
}
