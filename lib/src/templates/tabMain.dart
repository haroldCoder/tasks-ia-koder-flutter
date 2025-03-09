import 'package:flutter/material.dart';

class TabMain extends StatelessWidget {
  const TabMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Tasks Koderx",
            style: TextStyle(
                color: Colors.white,
                fontFamily: "recursive",
                fontSize: 21,
                decoration: TextDecoration.none)),
        Icon(
          Icons.help,
          size: 30,
          color: Color(0xFFFFFFFF),
        )
      ],
    );
  }
}
