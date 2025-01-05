import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Widget child;
  final bool selected;
  final VoidCallback onPressed;

  const Button({
    super.key,
    this.selected = false,
    required this.child,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        side: BorderSide(
          color: Theme.of(context).colorScheme.secondary,
        ),
        backgroundColor: selected ? Theme.of(context).colorScheme.secondaryContainer : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
        )
      ),
      onPressed: () {
        onPressed();
      },
      child: child,
    );
  }
}
