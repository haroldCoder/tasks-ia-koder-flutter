import 'package:flutter/material.dart';
import 'package:tasks_ia_koderx/src/widgets/TextBoxs/TextBoxs.dart';

class TextboxsDescription extends StatefulWidget {
  const TextboxsDescription({
    super.key,
    required this.value,
    required this.onChange,
  });

  final String value;
  final Function(dynamic value) onChange;

  @override
  State<TextboxsDescription> createState() => _TextboxsDescriptionState();
}

class _TextboxsDescriptionState extends State<TextboxsDescription> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return TextBoxs(
      value: _controller,
      onChange: widget.onChange,
      max_lines: 10,
      min_lines: 8,
      height_container: 220,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: "Descripción de la tarea",
        hintStyle: TextStyle(color: Colors.grey[400]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Color(0xBCC1CAFF), width: 2),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      ),
    );
  }
}
