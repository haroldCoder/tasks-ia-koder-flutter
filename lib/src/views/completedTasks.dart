import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:tasks_ia_koderx/src/providers/task_providers.dart';
import 'package:tasks_ia_koderx/src/providers/uploaded_providers.dart';
import 'package:tasks_ia_koderx/src/shared/interfaces/updateTask.interface.dart';
import 'package:tasks_ia_koderx/src/shared/lang/completedTask/lang.dart';
import 'package:tasks_ia_koderx/src/shared/layouts/AreNoTasks.dart';
import 'package:tasks_ia_koderx/src/shared/layouts/ConnectionInternet/ConnectionInternet.dart';
import 'package:tasks_ia_koderx/src/shared/utils/users/getEmailUserApp.dart';
import 'package:tasks_ia_koderx/src/templates/tabBarFooter/tabBarFooter.dart';
import 'package:tasks_ia_koderx/src/templates/tabMain.dart';
import 'package:tasks_ia_koderx/src/views/completedTasks/layouts/TasksDisplay/TasksDisplay.dart';
import '../widgets/Search.dart';

class Completedtasks extends ConsumerStatefulWidget {
  const Completedtasks({super.key, required this.colorApp});

  final Rx<Color> colorApp;

  @override
  ConsumerState<Completedtasks> createState() => _CompletedtasksState();
}

class _CompletedtasksState extends ConsumerState<Completedtasks> {
  @override
  void initState() {
    super.initState();
    getUploadedTasksUser();
  }

  Future<void> getUploadedTasksUser() async {
    final email = await getEmailUser();
    ref.read(uploadedTasksProvider.notifier).getUploadedTasks(email);
  }

   changeToPendingTask(String id) async {
    final taskController = ref.read(taskUseCasesProvider.notifier);
    await taskController.updateTask(UpdateTasksInterface(completed: 0), id);
  }

  @override
  Widget build(BuildContext context) {
    final taskUploadedState = ref.watch(uploadedTasksProvider);
    final taskLocalState = ref.watch(taskUseCasesProvider);
    final completedLocalTasks = taskLocalState.tasks
        .where((task) => task.completed == 1)
        .toList();

    return Scaffold(
      backgroundColor: widget.colorApp.value,
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
              height: 400,
              child: taskUploadedState.when(data: (value) {
                if(completedLocalTasks.isEmpty && value.isEmpty){
                  return AreNoTasks();
                }
                return TaskDisplay(
                    localTasks: completedLocalTasks,
                    onlineTasks: value,
                    changeToPendingTask: changeToPendingTask);
              }, error: (err, _) {
                if (taskLocalState.tasks
                    .where((task) => task.completed == 1)
                    .isEmpty) {
                  return AreNoTasks();
                }

                return TaskDisplay(
                  localTasks: completedLocalTasks,
                  onlineTasks: [],
                  changeToPendingTask: changeToPendingTask,
                );
              }, loading: () {
                return const Center(child: CircularProgressIndicator());
              })),
          Expanded(
              child: Stack(
            children: [
              Positioned(
                  bottom: 4,
                  right: 110,
                  child: Text(
                      style: TextStyle(color: Colors.white30, fontSize: 17),
                      '${completedLocalTasks.length} $tasksCompleted'))
            ],
          )),
          TabBarFooter()
        ],
      )),
    );
  }
}
