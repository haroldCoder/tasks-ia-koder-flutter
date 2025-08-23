import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:tasks_ia_koderx/src/shared/States/Tasks/TaskController.dart';
import 'package:tasks_ia_koderx/src/shared/States/Visited_App/VisitedService.dart';
import 'package:tasks_ia_koderx/src/shared/lang/home/lang.dart';
import 'package:tasks_ia_koderx/src/shared/layouts/AreNoTasks.dart';
import 'package:tasks_ia_koderx/src/shared/layouts/ConnectionInternet/ConnectionInternet.dart';
import 'package:tasks_ia_koderx/src/templates/tabBarFooter/tabBarFooter.dart';
import 'package:tasks_ia_koderx/src/templates/tabMain.dart';
import 'package:tasks_ia_koderx/src/templates/update-tasks/update-tasks.dart';
import 'package:tasks_ia_koderx/src/widgets/Button/Button.dart';
import 'package:tasks_ia_koderx/src/widgets/Button/shared/class/button.dart';
import 'package:tasks_ia_koderx/src/widgets/Search.dart';
import 'package:tasks_ia_koderx/src/widgets/TaskContainer/TaskContainer.dart';
import 'package:intl/date_symbol_data_local.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.colorApp});
  final Rx<Color> colorApp;

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late AnimationController controller;

  clickButtonAddTask() {
    Future.microtask(() => context.push("/create-tasks"));
  }

  final TaskController taskController = Get.put(TaskController());
  VisitedService visitedService = VisitedService();

  @override
  void initState() {
    super.initState();
    this._initializeData();
  }

  void _initializeData() async {
    await initializeDateFormatting('es_ES', null);
    DateTime now = DateTime.now();
    String formattedDate =
        DateFormat('EEEE, dd MMMM yyyy', 'es_ES').format(now);
    await visitedService.saveLogged(formattedDate);
  }

  selectAllTasks() {
    if (taskController.tasks.where((task) => task.completed == 0).isEmpty) {
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
      List<int> task_remove = taskController.tasks
          .where((task) => task.completed == 0)
          .map((task) => task.id)
          .toList();
      taskController.AssignTasksSelected(task_remove);
    }
  }

  deleteAllTasks() {
    taskController.deleteSeveralTasks(taskController.selectedTasks);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            height: double.infinity,
            decoration: BoxDecoration(color: widget.colorApp.value),
            child: Stack(
              children: [
                Container(
                  height: double.infinity,
                  decoration: BoxDecoration(color: widget.colorApp.value),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 65,
                        padding: EdgeInsets.symmetric(horizontal: 10),
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
                      SizedBox(height: 30),
                      Container(
                        height: 300,
                        child: Obx(() {
                          final taskPending = taskController.tasks
                              .where((task) => task.completed == 0)
                              .toList();

                          if (taskPending.isEmpty) {
                            return AreNoTasks();
                          }

                          return SingleChildScrollView(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Column(
                              spacing: 15,
                              children: taskPending.map((task) {
                                return TaskContainer(
                                  id: task.id,
                                  title: task.title,
                                  description: task.description,
                                  priority: task.priority,
                                  onClick: () {
                                    showShadDialog(
                                      context: context,
                                      builder: (context) => UpdateTasks(
                                        complete: task.completed,
                                        id: task.id,
                                        title: task.title,
                                        description: task.description,
                                        priority: task.priority,
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                          );
                        }),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 10,
                          children: [
                            Button(
                              click: selectAllTasks,
                              style: ButtonStyle(
                                shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Colors.white),
                              ),
                              contentbtn: Obx(() {
                                return Text(
                                  taskController.selectedTasks.isEmpty
                                      ? selectAll
                                      : deselectAll,
                                  style: TextStyle(color: Color(0xFF4439FF)),
                                );
                              }),
                            ),
                            Button(
                              click: deleteAllTasks,
                              style: ButtonStyle(
                                shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Colors.blueAccent),
                              ),
                              contentbtn: Text(
                                removeAll,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      TabBarFooter(),
                    ],
                  ),
                ),
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
