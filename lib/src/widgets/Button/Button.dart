import 'package:flutter/material.dart';
import 'package:tasks_ia_koderx/src/widgets/Button/shared/class/button.dart';

class Button extends StatefulWidget {
  const Button(
      {super.key,
      this.click,
      this.style,
      this.position,
      this.contentbtn,
      this.width,
      this.padding});

  final ButtonStyle? style;
  final VoidCallback? click;
  final Widget? contentbtn;
  final ButtonPosition? position;
  final double? width;
  final EdgeInsets? padding;

  @override
  State<StatefulWidget> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            bottom: widget.position?.bottom,
            right: widget.position?.right,
            top: widget.position?.top,
            left: widget.position?.left,
            child: Container(
              padding: widget.padding,
              width: widget.width,
              child: ElevatedButton(
                onPressed: widget.click,
                child: widget.contentbtn,
                style: widget.style,
              ),
            ))
      ],
    );
  }
}
