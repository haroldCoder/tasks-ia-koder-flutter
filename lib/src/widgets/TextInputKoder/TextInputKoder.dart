import 'package:flutter/material.dart';

class TextInputKoder extends StatelessWidget {
  const TextInputKoder(
      {super.key,
      this.value,
      this.type,
      this.style,
      this.decoration,
      required this.onChange});

  final String? type;
  final TextEditingController? value;
  final TextStyle? style;
  final InputDecoration? decoration;
  final ValueChanged onChange;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: this.type == "password" ? true : false,
      decoration: decoration,
      style: style,
      onChanged: onChange,
      controller: value,
    );
  }
}
