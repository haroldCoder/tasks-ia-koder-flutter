import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks_ia_koderx/src/constants/class/radiointerface.dart';

class Radiocheck extends StatefulWidget{
  Radiocheck(
      {super.key,
        required this.list,
        required this.onChange,
        required this.value,
        this.textStyle});

  final List<RadioInterface> list;
  final ValueChanged<dynamic>? onChange;
  final dynamic value;
  final TextStyle? textStyle;

  @override
  State<Radiocheck> createState() => _RadiocheckState();
}

class _RadiocheckState extends State<Radiocheck> {

  dynamic selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: ListView(
        children: [
          for (int i = 0; i < widget.list.length; i++)
            RadioListTile(
              value: widget.list[i].value ?? 0,
              title: Text(
                widget.list[i].title ?? "Sin título",
                style: widget.textStyle ?? TextStyle(color: Colors.white),
              ),
              groupValue: selectedValue ?? 0,
              onChanged: (value){setState(() {
                selectedValue = value;
              }); widget.onChange!(value);},
            ),
        ],
      ),
    );
  }
}
