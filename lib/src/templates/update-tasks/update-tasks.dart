import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:tasks_ia_koderx/src/constants/updateTaskOptions.dart';
import 'package:tasks_ia_koderx/src/shared/States/Tasks/task_service.dart';
import 'package:tasks_ia_koderx/src/shared/interfaces/updateTask.interface.dart';
import 'package:tasks_ia_koderx/src/shared/lang/home/lang.dart';
import 'package:tasks_ia_koderx/src/views/states/createTaskState.dart';
import 'package:tasks_ia_koderx/src/widgets/Button/Button.dart';
import 'package:tasks_ia_koderx/src/widgets/PopUp/PopUp.dart';
import 'package:tasks_ia_koderx/src/widgets/Select/Select.dart';
import 'package:tasks_ia_koderx/src/widgets/TextBoxs/TextBoxs.dart';
import 'package:tasks_ia_koderx/src/widgets/TextInputKoder/TextInputKoder.dart';

class UpdateTasks extends StatefulWidget {
  UpdateTasks(
      {super.key,
      required this.id,
      required this.title,
      required this.description,
      required this.priority,
      required this.complete});
  String title;
  String description;
  int priority;
  int id;
  int complete;

  void changeTitle(value) {
    this.title = value;
  }

  void changeDescription(value) {
    this.description = value;
  }

  void changePriority(String? value) {
    this.priority = int.parse(value!);
  }

  void updateDate(BuildContext context) async {
    if (await TaskService().updateTask(
            UpdateTasksInterface(
                completed: complete,
                title: title,
                description: description,
                priority: priority),
            id) >=
        1) {
      ShadToaster.of(context).show(ShadToast(
        alignment: Alignment.topCenter,
        backgroundColor: Colors.black,
        border: Border(
            top: BorderSide(color: Colors.green, width: 2),
            bottom: BorderSide(color: Colors.green, width: 2),
            left: BorderSide(color: Colors.green, width: 2),
            right: BorderSide(color: Colors.green, width: 2)),
        title: Text(
          taskUpdateSuccesfully,
          style: TextStyle(color: Colors.green),
        ),
      ));
      GoRouter.of(context).pop();
    } else {
      ShadToaster.of(context).show(ShadToast(
        alignment: Alignment.topCenter,
        backgroundColor: Colors.black,
        border: Border(
            top: BorderSide(color: Colors.red, width: 2),
            bottom: BorderSide(color: Colors.red, width: 2),
            left: BorderSide(color: Colors.red, width: 2),
            right: BorderSide(color: Colors.red, width: 2)),
        title: Text(
          ocurredError,
          style: TextStyle(color: Colors.red),
        ),
      ));
    }
  }

  @override
  State<UpdateTasks> createState() => _UpdateTasksState();
}

class _UpdateTasksState extends State<UpdateTasks> {
  void changeStateTask() {
    setState(() {
      widget.complete = widget.complete == 1 ? 0 : 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
          child: PopUp(
              bg: Color(0xAAAAAAAA),
              radius: BorderRadius.circular(10),
              border: Border(
                  right: BorderSide(color: Colors.blueAccent, width: 1),
                  left: BorderSide(color: Colors.blueAccent, width: 1),
                  top: BorderSide(color: Colors.blueAccent, width: 1),
                  bottom: BorderSide(color: Colors.blueAccent, width: 1)),
              actions: [
                Container(
                  alignment: Alignment.bottomRight,
                  child: Button(
                    click: () {
                      widget.updateDate(context);
                    },
                    contentbtn: Text(btnUpdate,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontFamily: 'inter',
                            fontWeight: FontWeight.bold)),
                    style: ButtonStyle(
                        shape: WidgetStatePropertyAll<OutlinedBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16))),
                        backgroundColor:
                            WidgetStatePropertyAll<Color>(Colors.blueAccent)),
                  ),
                )
              ],
              child: Material(
                color: Colors.transparent,
                child: Container(
                    margin: EdgeInsets.only(top: 15),
                    decoration: BoxDecoration(color: Colors.transparent),
                    child: SingleChildScrollView(
                      child: Column(
                        spacing: 10,
                        children: [
                          TextInputKoder(
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                fillColor: Colors.white12,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                      color: Colors.blueAccent, width: 2),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(1.0),
                                    borderSide: BorderSide(
                                        color: Colors.blueAccent, width: 2)),
                              ),
                              onChange: widget.changeTitle,
                              value: TextEditingController(text: widget.title)),
                          TextBoxs(
                              height_container: 220,
                              max_lines: 10,
                              min_lines: 8,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                fillColor: Colors.white12,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                      color: Colors.blueAccent, width: 2),
                                ),
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                        color: Color(0xBCC1CAFF), width: 2)),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15),
                              ),
                              onChange: widget.changeDescription,
                              value: TextEditingController(
                                  text: widget.description)),
                          Column(
                            spacing: 8,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.bottomLeft,
                                child: Select(
                                    onchange: widget.changePriority,
                                    decoration: ShadDecoration(
                                        color: Colors.white,
                                        border: ShadBorder(
                                            radius: BorderRadius.circular(8.0),
                                            right: ShadBorderSide(
                                                color: Colors.blueAccent,
                                                width: 2),
                                            left: ShadBorderSide(
                                                color: Colors.blueAccent,
                                                width: 2),
                                            top: ShadBorderSide(
                                                color: Colors.blueAccent,
                                                width: 2),
                                            bottom: ShadBorderSide(
                                                color: Colors.blueAccent,
                                                width: 2))),
                                    options: updateTaskOptions,
                                    placeholder: widget.priority == 1
                                        ? Text(hightPriorityHome)
                                        : widget.priority == 2
                                            ? Text(mediumPriorityHome)
                                            : Text(lowPriorityHome)),
                              ),
                              Button(
                                click: () {
                                  changeStateTask();
                                },
                                style: ButtonStyle(
                                  shape: WidgetStatePropertyAll<OutlinedBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16))),
                                  backgroundColor:
                                      WidgetStatePropertyAll<Color>(
                                        widget.complete == 1
                                            ? Colors.green
                                            : Colors.transparent),
                                  padding: WidgetStatePropertyAll<EdgeInsets>(
                                      EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 10)),
                                  minimumSize:
                                      WidgetStatePropertyAll<Size>(Size(0, 0)),

                                ),
                                contentbtn: Text(
                                  widget.complete == 1
                                      ? btnComplete
                                      : btnCompleted,
                                  style: TextStyle(color: widget.complete == 1
                                      ? Colors.white
                                      : Colors.blueAccent),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )),
              )),
        ),
      ),
    );
  }
}
