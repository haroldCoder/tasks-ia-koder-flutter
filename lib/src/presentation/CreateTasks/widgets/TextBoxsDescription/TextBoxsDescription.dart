import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tasks_ia_koderx/src/shared/lang/createTask/lang.dart';
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
  void didUpdateWidget(covariant TextboxsDescription oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      final previousSelection = _controller.selection;
      _controller.value = TextEditingValue(
        text: widget.value,
        selection: previousSelection.copyWith(
          baseOffset: min(previousSelection.start, widget.value.length),
          extentOffset: min(previousSelection.end, widget.value.length),
        ),
      );
    }
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
        hintText: descriptionLabel,
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
