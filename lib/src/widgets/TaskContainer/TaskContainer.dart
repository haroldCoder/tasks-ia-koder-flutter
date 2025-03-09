import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:tasks_ia_koderx/src/widgets/ButtonUpload/ButtonUpload.dart';

class TaskContainer extends StatefulWidget {
  TaskContainer(
      {super.key,
      this.title = "Test",
      this.description = "Test description",
      this.priority = 1,
      this.onClick,
      this.completed = false});

  final String title;
  final String description;
  final int priority;
  final VoidCallback? onClick;
  final bool? completed;

  @override
  State<StatefulWidget> createState() {
    return _TaskContainerState();
  }
}

class _TaskContainerState extends State<TaskContainer> {
  @override
  Widget build(BuildContext context) {
    return ShadCard(
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
              onPressed: widget.onClick,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              backgroundColor: widget.completed! ? Colors.black : Colors.transparent,
              decoration: ShadDecoration(
                  border: ShadBorder.all(color: Color(0xFF5B36FF), width: .5)),
              child: Text(
                !widget.completed! ? "Editar" : "Devolver",
                style: TextStyle(
                    color:
                        !widget.completed! ? Color(0xFF5B36FF) : Colors.white,
                    fontSize: 15),
              ),
            ),
            !widget.completed!
                ? Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        color: widget.priority == 1
                            ? Colors.red
                            : widget.priority == 2
                                ? Colors.orange
                                : Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(5))))
                : Buttonupload()
          ],
        ),
      ),
    );
  }
}
