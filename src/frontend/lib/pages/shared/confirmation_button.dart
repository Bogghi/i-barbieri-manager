import 'package:flutter/material.dart';

class ConfirmationButton extends StatelessWidget {
  final String label;
  final Widget ?child;
  final VoidCallback onPressed;

  const ConfirmationButton({
    super.key,
    required this.onPressed,
    this.child,
    this.label = 'Confirmation Button'
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
          ),
        ),
        onPressed: onPressed,
        child: child ?? defaultLabel()
    );
  }
  Widget defaultLabel() {
    return Text(
      label,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25,)
    );
  }
}
