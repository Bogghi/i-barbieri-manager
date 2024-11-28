import 'package:flutter/material.dart';

class Panel extends StatelessWidget {
  final Widget child;
  final double width;
  final double ?height;
  final VoidCallback? onTap;

  const Panel({
    super.key,
    required this.child,
    this.width = double.infinity,
    this.height,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return onTap != null ? InkWell(
      onTap: () {
        if(onTap != null){
          onTap!();
        }
      },
      child: container(context),
    ) : container(context);
  }
  
  Widget container(BuildContext context) {
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
