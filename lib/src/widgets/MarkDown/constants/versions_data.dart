import 'package:flutter/material.dart';

class Versions {
  String name;
  Color firstColor;
  Color secondColor;

  Versions({
    required this.name,
    required this.firstColor,
    required this.secondColor,
  });
}
List<Versions> versions = [
  Versions(
    name: "Beta",
    firstColor: Colors.blue,
    secondColor: Colors.greenAccent,
  ),
  Versions(
    name: "Latest",
    firstColor: Colors.yellowAccent,
    secondColor: Colors.brown,
  ),
];