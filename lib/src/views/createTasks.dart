import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:tasks_ia_koderx/src/constants/radioList.dart';
import 'package:tasks_ia_koderx/src/shared/States/Tasks/task_service.dart';
import 'package:tasks_ia_koderx/src/views/states/createTaskState.dart';
import 'package:tasks_ia_koderx/src/widgets/Button/Button.dart';
import 'package:tasks_ia_koderx/src/widgets/RadioCheck/RadioCheck.dart';
import 'package:tasks_ia_koderx/src/widgets/TextBoxs/TextBoxs.dart';
import 'package:tasks_ia_koderx/src/widgets/TextInputKoder/TextInputKoder.dart';

class Createtasks extends StatelessWidget {
  Createtasks({super.key});
  Rx<CreateTasksState> task = CreateTasksState().obs;

  backPage(BuildContext context) {
    if (!context.mounted) return;
    Future.microtask(() => context.pop());
  }

  handleChangeTitleTask(value) {
    task.update((t) {
      if (t != null) t.setTitle(value);
    });
    task.refresh();
  }

  handleChangeDescriptionTask(value) {
    task.update((t) {
      if (t != null) t.setDescription(value);
    });
    task.refresh();
  }

  handeChangePriority(value) {
    task.update((t) {
      if (t != null) t.setPriorityValue(value);
    });
    task.refresh();
  }

  createTask(BuildContext context) async {
    TaskService().saveTasks(task.value.title_task, task.value.description,
        task.value.value_priority);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Tarea creada con éxito"),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );

    task.update((t) {
      if (t != null) t.resetData();
    });
    task.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: true,
        body: Obx(() {
          return Container(
            height: double.infinity,
            padding: EdgeInsets.only(left: 15, right: 15),
            child: SingleChildScrollView(
                child: ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                Container(
                    height: 50,
                    width: double.infinity,
                    child: Stack(children: [
                      Button(
                        style: ButtonStyle(
                            alignment: Alignment.centerLeft,
                            padding: MaterialStatePropertyAll<EdgeInsets>(
                                EdgeInsets.all(0)),
                            backgroundColor: MaterialStatePropertyAll<Color>(
                                Colors.transparent)),
                        click: () => backPage(context),
                        contentbtn: Icon(
                          Icons.arrow_back,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                    ])),
                Container(
                    margin: EdgeInsets.only(top: 30),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Crear Tareas",
                            style: TextStyle(
                                fontFamily: "normal",
                                fontSize: 30,
                                decoration: TextDecoration.none,
                                color: Colors.white),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 50),
                            height: 50,
                            child: Scaffold(
                              resizeToAvoidBottomInset: false,
                              backgroundColor: Colors.transparent,
                              body: TextInputKoder(
                                value: TextEditingController(
                                    text: task.value.title_task)
                                  ..selection = TextSelection.fromPosition(
                                    TextPosition(
                                        offset: task.value.title_task.length),
                                  ),
                                onChange: handleChangeTitleTask,
                                style: TextStyle(
                                    background: Paint()..color = Colors.black,
                                    color: Colors.white),
                                decoration: InputDecoration(
                                    labelStyle: TextStyle(color: Colors.white),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    labelText: "Crear tarea",
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xBCC1CAFF), width: 2),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)))),
                              ),
                            ),
                          ),
                          TextBoxs(
                              value: TextEditingController(
                                  text: task.value.description)
                                ..selection = TextSelection.fromPosition(
                                    TextPosition(
                                        offset: task.value.description.length)),
                              onChange: handleChangeDescriptionTask,
                              max_lines: 10,
                              min_lines: 8,
                              height_container: 220,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                hintText: "Descripción de la tarea",
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                        color: Color(0xBCC1CAFF), width: 2)),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15),
                              )),
                          Container(
                            margin: EdgeInsets.only(bottom: 30),
                            width: double.infinity,
                            height: 140,
                            child: Radiocheck(
                              value: task.value.value_priority,
                              onChange: handeChangePriority,
                              list: priorityOptions,
                            ),
                          ),
                          Button(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            click: () => createTask(context),
                            contentbtn: Text("Crear Tarea",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontFamily: 'inter',
                                    fontWeight: FontWeight.bold)),
                            style: ButtonStyle(
                                shape: WidgetStatePropertyAll<OutlinedBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16))),
                                backgroundColor: WidgetStatePropertyAll<Color>(
                                    Colors.blueAccent)),
                          ),
                        ],
                      ),
                    ))
              ],
            )),
          );
        }));
  }
}
