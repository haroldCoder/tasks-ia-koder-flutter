import 'package:flutter/material.dart';
import 'package:tasks_ia_koderx/src/widgets/MarkDown/constants/versions_data.dart';


class Markdown extends StatelessWidget {
  const Markdown({super.key, this.version = "Beta"});
  final String? version;

  @override
  Widget build(BuildContext context) {
    Versions? selectedVersion = versions.firstWhere(
      (vr) => vr.name == version,
    );
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 22),
      child: Text(
        selectedVersion.name,
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [selectedVersion.firstColor, selectedVersion.secondColor]),
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
    );
  }
}
