import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class PopUp extends StatelessWidget {
  const PopUp(
      {super.key,
      this.title,
      this.description,
      required this.actions,
      this.child,
      this.bg,
      this.border,
      this.radius});
  final Widget? title;
  final Widget? description;
  final List<Widget> actions;
  final Widget? child;
  final Color? bg;
  final Border? border;
  final BorderRadius? radius;

  @override
  Widget build(BuildContext context) {
    return ShadDialog(
        border: border,
        radius: radius,
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
        closeIcon: GestureDetector(
          onTap: () {
            GoRouter.of(context).pop();
          },
          child:
        Icon(Icons.close, color: Colors.white38, size: 25,)),
        closeIconData: IconData(1),
        backgroundColor: bg ?? Color(0x99FFFFFF),
        title: this.title,
        description: this.description,
        actions: this.actions,
        child: this.child);
  }
}
