import 'package:flutter/material.dart';

class PresentationCases extends StatelessWidget {
  const PresentationCases({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: child,
    );
  }
}