import 'package:flutter/material.dart';
import 'package:tasks_ia_koderx/src/shared/lang/agentIA/lang.dart';
import 'package:tasks_ia_koderx/src/widgets/PopUp/PopUp.dart';

class ErrorAgentIA extends StatelessWidget {
  const ErrorAgentIA({super.key, required this.description});
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: PopUp(
        title: Text(errorTitle, style: TextStyle(color: Colors.red)),
        description: Text(description, style: TextStyle(color: Colors.white60)),
        actions: [],
        bg: Colors.black,
      ),
    );
  }
}
