import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:tasks_ia_koderx/src/views/states/createTaskState.dart';
import 'package:tasks_ia_koderx/src/widgets/Button/Button.dart';
import 'package:tasks_ia_koderx/src/widgets/TextBoxs/TextBoxs.dart';
import 'package:tasks_ia_koderx/src/widgets/TextInputKoder/TextInputKoder.dart';

class Createtasks extends StatelessWidget {
  Createtasks({super.key});
  CreateTasksState task = CreateTasksState();

  backPage(BuildContext context) {
    if (!context.mounted) return;
    Future.microtask(() => context.pop());
  }

  handleChangeTitleTask(value){
    task.setTitle(value);
  }

  handleChangeDescriptionTask(value){
    task.setDescription(value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        padding: EdgeInsets.only(left: 15, right: 15),
        child: ListView(
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
                    margin: EdgeInsets.symmetric(horizontal: 0, vertical: 50),
                    height: 50,
                    child: Scaffold(
                      resizeToAvoidBottomInset: false,
                      backgroundColor: Colors.transparent,
                      body: TextInputKoder(
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)))),
                      ),
                    ),
                  ),
                  TextBoxs(
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
                            borderSide:
                                BorderSide(color: Color(0xBCC1CAFF), width: 2)),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 15),
                      )),
                ],
              ),
            )
          ],
        ));
  }
}
