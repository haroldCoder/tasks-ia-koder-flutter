import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:tasks_ia_koderx/src/shared/States/Tasks/TaskController.dart';
import 'package:tasks_ia_koderx/src/shared/States/Tasks/task_service.dart';
import 'package:tasks_ia_koderx/src/shared/States/Visited_App/VisitedService.dart';
import 'package:tasks_ia_koderx/src/shared/States/Visited_App/interface/visited_table.dart';
import 'package:tasks_ia_koderx/src/templates/tabBarFooter/tabBarFooter.dart';
import 'package:tasks_ia_koderx/src/templates/tabMain.dart';
import 'package:tasks_ia_koderx/src/templates/update-tasks/update-tasks.dart';
import 'package:tasks_ia_koderx/src/widgets/Animations/Animations.dart';
import 'package:tasks_ia_koderx/src/widgets/Button/Button.dart';
import 'package:tasks_ia_koderx/src/widgets/Button/shared/class/button.dart';
import 'package:tasks_ia_koderx/src/widgets/Search.dart';
import 'package:tasks_ia_koderx/src/widgets/TaskContainer/TaskContainer.dart';
import 'package:intl/date_symbol_data_local.dart';

class MyHomePage extends StatefulWidget{
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late AnimationController _controller;

  clickButtonAddTask() {
    Future.microtask(() => context.push("/create-tasks"));
  }

  final TaskController taskController = Get.put(TaskController());

  final TaskService taskService = TaskService();
  VisitedService visitedService = VisitedService();

  @override
  void initState(){
    super.initState();
    this._initializeData();
  }

  void _initializeData() async {
    await initializeDateFormatting('es_ES', null);
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEE, dd MMMM yyyy', 'es_ES').format(now);
    await visitedService.saveLogged(formattedDate);
  }

  selectAllTasks() {
    if (taskController.tasks.where((task) => task.complete == 0).isEmpty) {
      showShadDialog(
          context: context,
          builder: (context) => Container(
                width: 200,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ShadDialog.alert(
                  border: Border.all(
                    color: Colors.red,
                  ),
                  radius: BorderRadius.all(new Radius.circular(20)),
                  backgroundColor: Colors.black,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: [
                      Icon(
                        Icons.error_outlined,
                        color: Colors.red,
                        size: 20,
                      ),
                      Text(
                        'No hay tareas',
                        style:
                            TextStyle(color: Colors.red, fontFamily: 'roboto'),
                      )
                    ],
                  ),
                ),
              ));
    } else {
      List<int> task_remove =
          taskController.tasks.where((task)=>task.complete == 0).map((task) => task.id!).toList();
      taskController.AssignTasksSelected(task_remove);
    }
  }

  deleteAllTasks(){
    taskService.deleteTasks(taskController.selectedTasks.toList());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            height: double.infinity,
            decoration: BoxDecoration(color: Colors.black),
            child: Stack(
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                    width: double.infinity,
                    height: 65,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(color: Colors.blueAccent),
                    child: TabMain(),
                  ),
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
                      child: Obx(() {
                        if (taskController.tasks
                            .where((task) => task.complete == 0)
                            .isEmpty) {
                          return Center(
                              child: ListView(
                            children: [
                              Animations(
                                duration: Duration(seconds: 1),
                                child: SvgPicture.asset('lib/assets/check.svg',
                                    width: 50, height: 50),
                                transitionBuilder: (Widget? child,
                                    AnimationController controller) {
                                  return ScaleTransition(
                                    scale: TweenSequence<double>([
                                      TweenSequenceItem(
                                          tween: Tween(begin: 1.0, end: 1.2),
                                          weight: 50),
                                      TweenSequenceItem(
                                          tween: Tween(begin: 1.2, end: 1.0),
                                          weight: 50),
                                    ]).animate(controller),
                                    child: Transform.rotate(
                                      angle: controller.value * 2.0 * pi,
                                      child: child,
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: 30),
                              Text(
                                "No hay tareas pendientes",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white54,
                                    decoration: TextDecoration.none,
                                    fontSize: 25,
                                    fontFamily: 'rubik'),
                              )
                            ],
                          ));
                        }
                        return SingleChildScrollView(
                          child: Column(
                            spacing: 15,
                            children: taskController.tasks
                                .where((task) => task.complete == 0)
                                .map<Widget>((task) => TaskContainer(
                                      id: task.id!,
                                      title: task.title_task,
                                      description: task.description,
                                      priority: task.value_priority,
                                      onClick: () {
                                        showShadDialog(
                                            context: context,
                                            builder: (context) => UpdateTasks(
                                                complete: task.complete,
                                                id: task.id ?? 0,
                                                title: task.title_task,
                                                description: task.description,
                                                priority: task.value_priority));
                                      },
                                    ))
                                .toList(),
                          ),
                        );
                      })),
                  Expanded(
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 10,
                            children: [
                              Button(
                                click: () {
                                  selectAllTasks();
                                },
                                style: ButtonStyle(
                                  shape:
                                      MaterialStatePropertyAll<OutlinedBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14))),
                                  backgroundColor:
                                      MaterialStatePropertyAll<Color>(
                                          Colors.white),
                                ),
                                contentbtn: Obx((){
                                  print(taskController.selectedTasks.isEmpty);
                                  return Text(
                                    taskController.selectedTasks.length == 0
                                        ? "Seleccionar todo"
                                        : "Deseleccionar todo",
                                    style: TextStyle(color: Color(0xFF4439FF)),
                                  );
                                }),
                              ),
                              Button(
                                click: (){
                                  deleteAllTasks();
                                },
                                style: ButtonStyle(
                                  shape:
                                      MaterialStatePropertyAll<OutlinedBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14))),
                                  backgroundColor:
                                      MaterialStatePropertyAll<Color>(
                                          Colors.blueAccent),
                                ),
                                contentbtn: Text(
                                  "Eliminar seleccionados",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ))),
                  TabBarFooter(),
                ]),
                Button(
                  click: this.clickButtonAddTask,
                  style: ButtonStyle(
                      backgroundColor: WidgetStateColor.transparent),
                  contentbtn: Icon(
                    Icons.add_circle_outline,
                    color: Colors.blueAccent,
                    size: 60,
                  ),
                  position: ButtonPosition(0, 250, 0, 540),
                )
              ],
            )));
  }
}
