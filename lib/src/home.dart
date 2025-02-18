import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tasks_ia_koderx/src/shared/States/Tasks/task_service.dart';
import 'package:tasks_ia_koderx/src/views/states/createTaskState.dart';
import 'package:tasks_ia_koderx/src/widgets/Animations/Animations.dart';
import 'package:tasks_ia_koderx/src/widgets/Button/Button.dart';
import 'package:tasks_ia_koderx/src/widgets/Button/shared/class/button.dart';
import 'package:tasks_ia_koderx/src/widgets/Search.dart';
import 'package:tasks_ia_koderx/src/widgets/TaskContainer/TaskContainer.dart';

class MyHomePage extends StatefulWidget {
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

  TaskService _taskService = TaskService();
  late List<CreateTasksState> tasks = [];

  @override
  void initState() {
    super.initState();
    _initTasks();
  }

  Future<void> _initTasks() async {
    List<CreateTasksState> fetchedTasks = await _taskService.getTasks();
    setState(() {
      tasks = fetchedTasks;
    });
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
                        child: tasks.isEmpty
                            ? Center(
                                child: ListView(
                                children: [
                                  Animations(
                                    duration: Duration(seconds: 1),
                                    child: SvgPicture.asset(
                                        'lib/assets/check.svg',
                                        width: 50,
                                        height: 50),
                                    transitionBuilder: (Widget? child,
                                        AnimationController controller) {
                                      return ScaleTransition(
                                        scale: TweenSequence<double>([
                                          TweenSequenceItem(
                                              tween:
                                                  Tween(begin: 1.0, end: 1.2),
                                              weight: 50),
                                          TweenSequenceItem(
                                              tween:
                                                  Tween(begin: 1.2, end: 1.0),
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
                              ))
                            : SingleChildScrollView(
                                child: Column(
                                  children: tasks
                                      .map<Widget>((task) => TaskContainer(
                                            title: task.title_task,
                                            description: task.description,
                                            priority: task.value_priority,
                                          ))
                                      .toList(),
                                ),
                              )),
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
