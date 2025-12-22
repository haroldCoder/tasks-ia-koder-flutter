import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:tasks_ia_koderx/src/providers/task_providers.dart';
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

class HomePage extends ConsumerStatefulWidget {
  HomePage({super.key, required this.title, required this.colorApp});
  final Color colorApp;

  final String title;

  @override
  ConsumerState<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<HomePage> {
  clickButtonAddTask() {
    Future.microtask(() => context.push("/create-tasks"));
  }

  VisitedService visitedService = VisitedService();

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() async {
    await initializeDateFormatting('es_ES', null);
    DateTime now = DateTime.now();
    String formattedDate =
        DateFormat('EEEE, dd MMMM yyyy', 'es_ES').format(now);
    await visitedService.saveLogged(formattedDate);
  }

  @override
  Widget build(BuildContext context) {
    final taskState = ref.watch(taskUseCasesProvider);
    final taskController = ref.read(taskUseCasesProvider.notifier);

    selectAllTasks() {
      if (taskState.tasks.where((task) => task.completed == 0).isEmpty) {
        showShadDialog(
            context: context,
            builder: (context) => Container(
                  width: 200,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ShadDialog.alert(
                    border: Border.all(
                      color: Colors.red,
                    ),
                    radius: const BorderRadius.all(Radius.circular(20)),
                    backgroundColor: Colors.black,
                    title: const Row(
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
                          style: TextStyle(
                              color: Colors.red, fontFamily: 'roboto'),
                        )
                      ],
                    ),
                  ),
                ));
      } else {
        List<int> task_remove = taskState.tasks
            .where((task) => task.completed == 0)
            .map((task) => task.id)
            .toList();
        taskController.assignTasksSelected(task_remove);
      }
    }

    deleteAllTasks() {
      taskController.deleteSeveralTasks(taskState.selectedTasks);
    }

    return SafeArea(
        child: Container(
            height: double.infinity,
            decoration: BoxDecoration(color: widget.colorApp),
            child: Stack(
              children: [
                Container(
                  height: double.infinity,
                  decoration: BoxDecoration(color: widget.colorApp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 65,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: const BoxDecoration(color: Colors.blueAccent),
                        child: const TabMain(),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        height: 20,
                        padding: const EdgeInsets.only(right: 8),
                        child: const ConnectionInternet(
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
                      const SizedBox(height: 30),
                      Container(
                        height: 300,
                        child: () {
                          final taskPending = taskState.tasks
                              .where((task) => task.completed == 0)
                              .toList();

                          if (taskPending.isEmpty) {
                            return const AreNoTasks();
                          }

                          return SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(
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
                        }(),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                                    const MaterialStatePropertyAll<Color>(
                                        Colors.white),
                              ),
                              contentbtn: Text(
                                taskState.selectedTasks.isEmpty
                                    ? selectAll
                                    : deselectAll,
                                style: const TextStyle(color: Color(0xFF4439FF)),
                              ),
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
                                    const MaterialStatePropertyAll<Color>(
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
                  click: clickButtonAddTask,
                  style: const ButtonStyle(
                      backgroundColor: WidgetStateColor.transparent),
                  contentbtn: const Icon(
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
