import 'package:flutter/material.dart';
import 'package:tasks_ia_koderx/src/widgets/Search.dart';

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
                    padding: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(color: Colors.blueAccent),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Tasks Koderx", style: TextStyle(color: Colors.white,
                          fontFamily: "recursive", fontSize: 21,
                          decoration: TextDecoration.none)),
                      Icon(
                        Icons.help,
                        size: 30,
                        color: Color(0xFFFFFFFF),
                      )
                    ],
                  )),
                SizedBox(
                  width: 250,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: const SearchWidget(margin: 20),
                      )
                    ],
                  ),
                )
              ],
            )));
  }
}
