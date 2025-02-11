import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tasks_ia_koderx/src/widgets/Button/Button.dart';
import 'package:tasks_ia_koderx/src/widgets/Button/shared/class/button.dart';
import 'package:tasks_ia_koderx/src/widgets/Search.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  clickButtonAddTask(){
    Future.microtask(()=>context.push("/create-tasks"));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            height: double.infinity,
            decoration: BoxDecoration(color: Colors.black),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: double.infinity,
                        height: 65,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(color: Colors.blueAccent),
                        child: Row(
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
                        )),
                    Center(
                      child: Container(
                        width: 250,
                        child: const SearchWidget(margin: 20),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      width: double.infinity,
                      padding: EdgeInsets.only(left: 15, right: 15),
                      height: 350,
                    ),
                  ],
                ),
                Button(
                  click: this.clickButtonAddTask,
                  style: ButtonStyle(
                      backgroundColor: WidgetStateColor.transparent),
                  contentbtn: Icon(
                    Icons.add_circle_outline,
                    color: Colors.blueAccent,
                    size: 70,
                  ),
                  position: ButtonPosition(0, 250, 0, 430),
                )
              ],
            )));
  }
}
