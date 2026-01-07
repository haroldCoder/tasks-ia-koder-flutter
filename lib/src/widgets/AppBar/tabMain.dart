import 'package:flutter/material.dart';
import 'package:tasks_ia_koderx/src/shared/layouts/LanguagueChange.dart';

class TabMain extends StatelessWidget {
  const TabMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Flex(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      direction: Axis.horizontal,
      children: [
        Text("Tasks Koderx",
            style: TextStyle(
                color: Colors.white,
                fontFamily: "recursive",
                fontSize: 21,
                decoration: TextDecoration.none)),
        Row(
          spacing: 1,
          children: [
            LanguagueChange(),
            Icon(
              Icons.help,
              size: 30,
              color: Color(0xFFFFFFFF),
            )
          ],
        )
      ],
    );
  }
}
