import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            decoration: BoxDecoration(color: Colors.black),
            child: Column(
              children: [
                Container(
                    width: double.infinity,
                    height: 65,
                    decoration: BoxDecoration(color: Colors.blueAccent))
              ],
            )));
  }
}
