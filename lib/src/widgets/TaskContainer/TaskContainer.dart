import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class TaskContainer extends StatefulWidget {
  TaskContainer(
      {super.key,
      this.title = "Test",
      this.description = "Test description",
      this.priority = 1});

  final String title;
  final String description;
  final int priority;

  @override
  State<StatefulWidget> createState() {
    return _TaskContainerState();
  }
}

class _TaskContainerState extends State<TaskContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: ShadCard(
              backgroundColor: Colors.white,
              shadows: [
                BoxShadow(
                  color: Colors.white70,
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
              width: double.infinity,
              title: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.title),
                    Icon(
                      Icons.close,
                      color: Color(0x9095A0FF),
                    )
                  ],
                ),
              ),
              description: Text(widget.description),
              border: Border.all(width: 1, color: Colors.blueAccent),
              radius: BorderRadius.all(Radius.circular(20)),
              padding: EdgeInsets.all(10),
              child: Container(
                margin: EdgeInsets.only(top: 15),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShadButton.outline(
                      height: 30,
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      decoration: ShadDecoration(
                          border: ShadBorder.all(
                              color: Color(0xFF5B36FF), width: .5)),
                      child: Text(
                        "Editar",
                        style:
                            TextStyle(color: Color(0xFF5B36FF), fontSize: 15),
                      ),
                    ),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: widget.priority == 1
                            ? Colors.red
                            : widget.priority == 2
                            ? Colors.orange
                            : Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(5)))
                    )
                  ],
                ),
              )),
        ));
  }
}
