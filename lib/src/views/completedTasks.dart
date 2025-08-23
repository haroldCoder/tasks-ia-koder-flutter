import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_ia_koderx/src/shared/interfaces/updateTask.interface.dart';
import 'package:tasks_ia_koderx/src/shared/lang/completedTask/lang.dart';
import 'package:tasks_ia_koderx/src/shared/layouts/AreNoTasks.dart';
import 'package:tasks_ia_koderx/src/shared/layouts/ConnectionInternet/ConnectionInternet.dart';
import 'package:tasks_ia_koderx/src/shared/utils/users/getEmailUserApp.dart';
import 'package:tasks_ia_koderx/src/templates/tabBarFooter/tabBarFooter.dart';
import 'package:tasks_ia_koderx/src/templates/tabMain.dart';
import 'package:tasks_ia_koderx/src/views/completedTasks/layouts/TasksDisplay/TasksDisplay.dart';
import 'package:tasks_ia_koderx/src/views/completedTasks/utils/uploadedTasks.dart';
import '../shared/States/Tasks/TaskController.dart';
import '../widgets/Search.dart';

class Completedtasks extends StatelessWidget {
  Completedtasks({super.key, required this.colorApp}) {
    getUploadedTasksUser();
  }

  final TaskController taskController = Get.put(TaskController());
  final UploadedTasks uploadedTasks = UploadedTasks();
  Rx<Color> colorApp;

  getUploadedTasksUser() async {
    uploadedTasks.getUploadedTasks(await getEmailUser());
  }

  changeToPendingTask(int id) async {
    await taskController.updateTask(UpdateTasksInterface(completed: 0), id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorApp.value,
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
                        .where((task) => task.completed == 1)
                        .isEmpty) {
                      return AreNoTasks();
                    }
                    return TaskDisplay(
                      localTasks: taskController.tasks
                          .where((task) => task.completed == 1)
                          .toList(),
                      onlineTasks: [],
                      changeToPendingTask: changeToPendingTask,
                    );
                  }

                  final tasks = snapshot.data;

                  return TaskDisplay(
                    localTasks: taskController.tasks
                        .where((task) => task.completed == 1)
                        .toList(),
                    onlineTasks: tasks,
                    changeToPendingTask: changeToPendingTask,
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
                      '${taskController.tasks.where((tasks) => tasks.completed == 1).length} ${tasksCompleted}'))
            ],
          )),
          TabBarFooter()
        ],
      )),
    );
  }
}
