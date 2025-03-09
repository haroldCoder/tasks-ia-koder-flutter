import 'package:flutter/material.dart';
import 'package:tasks_ia_koderx/src/widgets/Button/Button.dart';

class Buttonupload extends StatelessWidget {
  const Buttonupload({super.key});

  @override
  Widget build(BuildContext context) {
    return Button(
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
