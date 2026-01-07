import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tasks_ia_koderx/src/shared/lang/createTask/lang.dart';
import 'package:tasks_ia_koderx/src/widgets/TextInputKoder/TextInputKoder.dart';

class InputTitle extends StatefulWidget {
  const InputTitle({super.key, required this.value, required this.onChange});

  final String value;
  final Function(dynamic value) onChange;

  @override
  State<InputTitle> createState() => _InputTitle();
}

class _InputTitle extends State<InputTitle> {
  late final TextEditingController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(covariant InputTitle oldWidget) {
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
    return TextInputKoder(
      value: _controller,
      onChange: widget.onChange,
      style: TextStyle(
          background: Paint()..color = Colors.black, color: Colors.white),
      decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.white),
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          labelText: titleLabel,
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFFFFFFF), width: 2),
              borderRadius: BorderRadius.all(Radius.circular(5)))),
    );
  }
}
