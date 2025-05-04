// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NeuBox extends StatelessWidget {
  final Widget? child;
  const NeuBox({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.background,
          boxShadow: [
            // Darker shadow on bottom right
            BoxShadow(
                color: Theme.of(context)
                    .colorScheme
                    .inversePrimary
                    .withValues(alpha: 0.2),
                blurRadius: 0.5,
                offset: Offset(1, 1)),
            BoxShadow(
                color: Theme.of(context)
                    .colorScheme
                    .inversePrimary
                    .withValues(alpha: 0.2),
                blurRadius: 0.5,
                offset: Offset(-1, -1))
            // Lighter shadow on top left
          ]),
      child: child,
    );
  }
}
