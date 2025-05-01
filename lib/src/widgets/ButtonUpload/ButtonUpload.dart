import 'package:flutter/material.dart';
import 'package:tasks_ia_koderx/src/widgets/Button/Button.dart';

class Buttonupload extends StatelessWidget {
  const Buttonupload({super.key, this.click});
  final VoidCallback? click;

  @override
  Widget build(BuildContext context) {
    return Button(
      click: click,
      padding: EdgeInsets.all(0),
      width: 40,
      style: ButtonStyle(
        padding: MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.all(0)),
        backgroundColor: MaterialStatePropertyAll<Color>(Colors.black),
        shape: MaterialStatePropertyAll<OutlinedBorder>(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100)
        ))
      ),
      contentbtn: Icon(Icons.upload_rounded, color: Colors.blueAccent),
    );
  }
}
