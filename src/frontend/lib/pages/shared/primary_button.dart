import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final ButtonStyle? style;
  final VoidCallback onPresssed;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPresssed,
    this.style
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: style ?? ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      onPressed: onPresssed,
      child: Text(
        label,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
          fontSize: 20,
        ),
      ),
    );
  }
}
