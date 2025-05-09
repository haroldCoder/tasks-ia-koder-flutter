import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:tasks_ia_koderx/src/widgets/Button/Button.dart';

class DialogUpdate extends StatelessWidget {
  const DialogUpdate({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return ShadDialog(
      title: Text(
        this.text,
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        Button(
            contentbtn: Text("volver"),
            style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.blueAccent),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                ))
            ),
            click: ()=>context.go("/check")
        )
      ],
    );;
  }
}
