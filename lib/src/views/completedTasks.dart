import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:tasks_ia_koderx/src/shared/interfaces/tasksServer.interface.dart';
import 'package:tasks_ia_koderx/src/shared/utils/users/getEmailUserApp.dart';
import 'package:tasks_ia_koderx/src/templates/tabBarFooter/tabBarFooter.dart';
import 'package:tasks_ia_koderx/src/templates/tabMain.dart';
import 'package:tasks_ia_koderx/src/views/completedTasks/utils/uploadedTasks.dart';
import '../shared/States/Tasks/TaskController.dart';
import '../shared/States/Tasks/task_service.dart';
import '../widgets/Animations/Animations.dart';
import '../widgets/Search.dart';
import '../widgets/TaskContainer/TaskContainer.dart';
import 'states/createTaskState.dart';

class Completedtasks extends StatelessWidget {
  Completedtasks({super.key, required this.color_app}) {
    getUploadedTasksUser();
  }

  final TaskController taskController = Get.put(TaskController());
  final UploadedTasks uploadedTasks = UploadedTasks();
  Rx<Color> color_app;
  late var tasksUser = [];

  getUploadedTasksUser() async {
    uploadedTasks.getUploadedTasks(await getEmailUser());
  }

  ChangeToPendingTask(int id, CreateTasksState task) async {
    await TaskService().updateTask(
        CreateTasksState(
            id: task.id ?? 0,
            title_task: task.title_task,
            description: task.description,
            value_priority: task.value_priority,
            complete: 0),
        id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color_app.value,
      body: SafeArea(
          child: Column(
        children: [
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
            child: StreamBuilder(
              stream: uploadedTasks.tasksController.stream,
              initialData: [],
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  if (taskController.tasks
                      .where((task) => task.complete == 1)
                      .isEmpty) {
                    return Center(
                      child: ListView(
                        children: [
                          Animations(
                            duration: const Duration(seconds: 1),
                            child: SvgPicture.asset(
                              'lib/assets/check.svg',
                              width: 50,
                              height: 50,
                            ),
                            transitionBuilder: (Widget? child,
                                AnimationController controller) {
                              return ScaleTransition(
                                scale: TweenSequence<double>([
                                  TweenSequenceItem(
                                    tween: Tween(begin: 1.0, end: 1.2),
                                    weight: 50,
                                  ),
                                  TweenSequenceItem(
                                    tween: Tween(begin: 1.2, end: 1.0),
                                    weight: 50,
                                  ),
                                ]).animate(controller),
                                child: Transform.rotate(
                                  angle: controller.value * 2.0 * pi,
                                  child: child,
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            "No hay tareas finalizadas",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white54,
                              decoration: TextDecoration.none,
                              fontSize: 25,
                              fontFamily: 'rubik',
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                }

                return Obx(() {
                  final tasks = snapshot.data;
                  final seenIds = <int>{};
                  tasksUser = [
                    ...tasks.where((tk) => seenIds.add(tk.id_task_app)),
                    ...taskController.tasks
                        .where((task) => task.complete == 1)
                        .where((tk) => seenIds.add(tk.id!))
                  ];

                  return SingleChildScrollView(
                    child: Column(
                      spacing: 10,
                      children: tasksUser
                          .map<Widget>((task) => TaskContainer(
                                online: task.runtimeType != CreateTasksState,
                                id: task.runtimeType == CreateTasksState
                                    ? task.id
                                    : task.id_task_app,
                                completed: task.runtimeType == CreateTasksState
                                    ? true
                                    : task.completed == 1,
                                title: task.runtimeType == CreateTasksState
                                    ? task.title_task
                                    : task.title,
                                description: task.description,
                                priority: task.runtimeType == CreateTasksState
                                    ? task.value_priority
                                    : task.priority,
                                onClick: () =>
                                    ChangeToPendingTask(task.id, task),
                              ))
                          .toList(),
                    ),
                  );
                });
              },
            ),
          ),
          Expanded(
              child: Stack(
            children: [
              Positioned(
                  bottom: 4,
                  right: 110,
                  child: Text(
                      style: TextStyle(color: Colors.white30, fontSize: 17),
                      '${taskController.tasks.where((tasks) => tasks.complete == 1).length} '
                      'tareas completadas'))
            ],
          )),
          TabBarFooter()
        ],
      )),
    );
  }
}
