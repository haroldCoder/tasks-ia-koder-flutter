import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_ia_koderx/src/shared/lang/completedTask/lang.dart';
import 'package:tasks_ia_koderx/src/shared/layouts/AreNoTasks.dart';
import 'package:tasks_ia_koderx/src/shared/layouts/ConnectionInternet/ConnectionInternet.dart';
import 'package:tasks_ia_koderx/src/shared/utils/users/getEmailUserApp.dart';
import 'package:tasks_ia_koderx/src/templates/tabBarFooter/tabBarFooter.dart';
import 'package:tasks_ia_koderx/src/templates/tabMain.dart';
import 'package:tasks_ia_koderx/src/views/completedTasks/utils/uploadedTasks.dart';
import '../shared/States/Tasks/TaskController.dart';
import '../shared/States/Tasks/task_service.dart';
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
          SizedBox(height: 20),
          Container(
            height: 20,
            padding: EdgeInsets.only(right: 8),
            child: ConnectionInternet(
              decoration: TextDecoration.none,
              font: 'rubik',
            ),
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
                }
                return Obx(() {
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    if (taskController.tasks
                        .where((task) => task.complete == 1)
                        .isEmpty) {
                      return AreNoTasks();
                    }
                  }

                  final tasks = snapshot.data;
                  final seenIds = <int>{};
                  tasksUser = [
                    ...tasks.where((tk) => seenIds.add(tk.id_task_app)),
                    ...taskController.tasks
                        .where((task) => task.complete == 1)
                        .where((tk) => seenIds.add(tk.id!))
                  ];

                  return Scrollbar(
                      thumbVisibility: true,
                      thickness: 6,
                      radius: Radius.circular(10),
                      trackVisibility: true,
                      interactive: true,
                      child: SingleChildScrollView(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        child: Column(
                          spacing: 10,
                          children: tasksUser
                              .map<Widget>((task) => TaskContainer(
                                    online:
                                        task.runtimeType != CreateTasksState,
                                    id: task.runtimeType == CreateTasksState
                                        ? task.id
                                        : task.id_task_app,
                                    completed:
                                        task.runtimeType == CreateTasksState
                                            ? true
                                            : task.completed == 1,
                                    title: task.runtimeType == CreateTasksState
                                        ? task.title_task
                                        : task.title,
                                    description: task.description,
                                    priority:
                                        task.runtimeType == CreateTasksState
                                            ? task.value_priority
                                            : task.priority,
                                    onClick: () =>
                                        ChangeToPendingTask(task.id, task),
                                  ))
                              .toList(),
                        ),
                      ));
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
                      '${taskController.tasks.where((tasks) => tasks.complete == 1).length} ${tasksCompleted}'))
            ],
          )),
          TabBarFooter()
        ],
      )),
    );
  }
}
