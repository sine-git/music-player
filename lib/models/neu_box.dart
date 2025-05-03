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
                color: Colors.grey.shade300,
                blurRadius: 15,
                offset: Offset(4, 4)),
            BoxShadow(
                color: Colors.grey.shade500,
                blurRadius: 15,
                offset: Offset(-4, -4))
            // Lighter shadow on top left
          ]),
      child: child,
    );
  }
}
