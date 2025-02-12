import 'package:flutter/material.dart';

class TextBoxs extends StatelessWidget {
  const TextBoxs(
      {Key? key,
      this.hintText = 'Task Description',
      this.onChanged,
      this.style,
      this.decoration,
      this.height_container,
      this.max_lines = 1,
      this.min_lines = 1,
      this.padding,
      this.margin,
      required this.onChange,
      this.value})
      : super(key: key);

  final String? hintText;
  final void Function(String)? onChanged;
  final TextStyle? style;
  final InputDecoration? decoration;
  final double? height_container;
  final int max_lines;
  final int min_lines;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final TextEditingController? value;
  final ValueChanged onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      alignment: Alignment.topLeft,
      height: height_container,
      padding: padding,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        persistentFooterAlignment: AlignmentDirectional.topStart,
        body: TextField(
            controller: value,
            maxLines: max_lines,
            minLines: min_lines,
            onChanged: onChange,
            style: style,
            decoration: decoration),
      ),
    );
  }
}
