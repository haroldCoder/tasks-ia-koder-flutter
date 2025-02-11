import 'package:flutter/material.dart';

class TextInputKoder extends StatelessWidget {
  const TextInputKoder(
      {super.key, this.value, this.type, this.style, this.decoration});

  final String? type;
  final String? value;
  final TextStyle? style;
  final InputDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: this.type == "password" ? true : false,
      decoration: decoration,
      style: style,
    );
  }
}
