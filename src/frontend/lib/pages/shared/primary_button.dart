import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final ButtonStyle? style;

  const PrimaryButton({
    super.key,
    required this.label,
    this.style
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: style ?? ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      onPressed: () {},
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
