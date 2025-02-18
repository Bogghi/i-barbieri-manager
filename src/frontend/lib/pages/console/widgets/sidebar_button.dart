import 'package:flutter/material.dart';

class SidebarButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onPressed;
  final bool active;

  const SidebarButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.active = false
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: active ? Theme.of(context).colorScheme.onPrimary : Colors.transparent,
        foregroundColor: active ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onPrimary,
        shadowColor: active ? Theme.of(context).colorScheme.shadow : Colors.transparent,
        iconColor: active ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSecondary,
      ),
      onPressed: onPressed,
      child: SizedBox(
        height: 40,
        child: icon
      ),
    );
  }
}
